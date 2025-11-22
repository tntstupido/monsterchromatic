class_name Projectile
extends Area2D

@export var speed: float = 700.0
@export var damage: float = 10.0
@export var max_life_time: float = 2.0

var life_time: float = 0.0
var direction: Vector2 = Vector2.RIGHT
var pool: Node # Typed as Node to avoid cyclic dependency or type issues, or use ObjectPoolScript

const ObjectPoolScript = preload("res://scenes/common/ObjectPool.gd")


func _ready() -> void:
	add_to_group("player_projectile")
	body_entered.connect(_on_body_entered)
	life_time = max_life_time


func _process(delta: float) -> void:
	position += direction * speed * delta
	life_time -= delta
	if life_time <= 0.0:
		_return_to_pool()


func _on_body_entered(body: Node) -> void:
	if not body or body == self:
		return

	if body.is_in_group("enemy") and body.has_method("take_damage"):
		body.take_damage(damage)
		_return_to_pool()


func _return_to_pool() -> void:
	if pool:
		pool.return_instance(self)
	else:
		queue_free()


func reset(pos: Vector2, dir: Vector2, spd: float, dmg: float) -> void:
	global_position = pos
	direction = dir
	speed = spd
	damage = dmg
	life_time = max_life_time
