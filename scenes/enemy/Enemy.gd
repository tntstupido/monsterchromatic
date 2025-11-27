extends CharacterBody2D

signal died(enemy)

@export var move_speed: float = 140.0
@export var acceleration: float = 600.0
@export var max_health: float = 30.0
@export var contact_damage: float = 10.0
@export var contact_cooldown: float = 0.7

var target: Node2D
var _health: float
var _contact_timer: float = 0.0


func _ready() -> void:
	_health = max_health
	add_to_group("enemy")


func _physics_process(delta: float) -> void:
	if target:
		var dir := (target.global_position - global_position).normalized()
		velocity = velocity.move_toward(dir * move_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)

	_contact_timer = max(0.0, _contact_timer - delta)
	var collision := move_and_collide(velocity * delta)

	if collision and collision.get_collider() and collision.get_collider().is_in_group("player"):
		_hit_player(collision.get_collider())


func take_damage(amount: float) -> void:
	_health -= amount
	if _health <= 0.0:
		_die()


func _hit_player(player: Node) -> void:
	if _contact_timer > 0.0:
		return
	_contact_timer = contact_cooldown
	if player.has_method("take_damage"):
		player.take_damage(contact_damage)


func _die() -> void:
	died.emit(self)
	queue_free()
