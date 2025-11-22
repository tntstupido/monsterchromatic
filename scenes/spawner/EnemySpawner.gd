extends Node

signal enemy_spawned(enemy)

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 1.4
@export var spawn_interval_min: float = 0.4
@export var spawn_radius: float = 520.0
@export var difficulty_ramp: float = 0.985

var player: Node2D
var spawn_root: Node

var _timer: float = 0.0
var _elapsed: float = 0.0
var _rng: RandomNumberGenerator = RandomNumberGenerator.new()


func _ready() -> void:
	_rng.randomize()
	if not spawn_root:
		spawn_root = get_parent()
	set_process(true)


func _process(delta: float) -> void:
	if not enemy_scene or not player:
		return

	_elapsed += delta
	_timer -= delta

	if _timer <= 0.0:
		var scaled_interval: float = max(spawn_interval_min, spawn_interval * pow(difficulty_ramp, _elapsed / 5.0))
		_timer = scaled_interval
		_spawn_enemy()


func _spawn_enemy() -> void:
	var enemy: Node = enemy_scene.instantiate()
	if enemy == null:
		return

	var angle := _rng.randf_range(0.0, TAU)
	var offset := Vector2.RIGHT.rotated(angle) * spawn_radius
	enemy.global_position = player.global_position + offset

	enemy.target = player

	spawn_root.add_child(enemy)
	enemy_spawned.emit(enemy)
