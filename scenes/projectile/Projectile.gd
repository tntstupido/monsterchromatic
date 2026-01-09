class_name Projectile
extends Area2D

@export var speed: float = 700.0
@export var damage: float = 10.0
@export var max_life_time: float = 2.0
@export var hit_sound: AudioStream
@export var pierce_count: int = 0  # Number of enemies projectile can pierce through (0 = no pierce)

var life_time: float = 0.0
var direction: Vector2 = Vector2.RIGHT
var pool: Node # Typed as Node to avoid cyclic dependency or type issues, or use ObjectPoolScript
var _pierced_enemies: Array = []  # Track enemies already hit to prevent double-hitting
var _remaining_pierce: int = 0

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
		# Skip if already hit this enemy
		if body in _pierced_enemies:
			return

		body.take_damage(damage)
		_pierced_enemies.append(body)

		# Play hit sound
		if hit_sound:
			AudioManager.play_sound(hit_sound, global_position)

		# Check if should return to pool or continue piercing
		if _remaining_pierce > 0:
			_remaining_pierce -= 1
		else:
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
	_pierced_enemies.clear()
	_remaining_pierce = pierce_count
