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


@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	if target:
		var dir := (target.global_position - global_position).normalized()
		velocity = velocity.move_toward(dir * move_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)

	# Flip sprite based on movement direction
	# Asset faces LEFT. 
	# Moving RIGHT (vel.x > 0) -> Flip (Scale.x = -1 or flip_h = true)
	# Moving LEFT (vel.x < 0) -> Normal (Scale.x = 1 or flip_h = false)
	if velocity.x > 0.1:
		sprite.flip_h = true
	elif velocity.x < -0.1:
		sprite.flip_h = false


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
	var gem_scene = preload("res://scenes/objects/Gem.tscn")
	var gem = gem_scene.instantiate()
	gem.global_position = global_position
	# Defer adding to ensure thread safety/physics state safety during callback
	get_parent().call_deferred("add_child", gem)
	
	died.emit(self)
	queue_free()
