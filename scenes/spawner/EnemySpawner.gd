extends Node

signal enemy_spawned(enemy)

@export var current_spawn_interval: float = 2.0
@export var spawn_radius: float = 520.0

var player: Node2D
var spawn_root: Node
var enemy_pool: Array[PackedScene] = []

var _timer: float = 0.0
var _rng: RandomNumberGenerator = RandomNumberGenerator.new()


func _ready() -> void:
	_rng.randomize()
	if not spawn_root:
		spawn_root = get_parent()
	set_process(true)


func _process(delta: float) -> void:
	if not player:
		return

	_timer -= delta

	if _timer <= 0.0:
		_timer = current_spawn_interval
		_spawn_enemy() # Spawn from pool


func _spawn_enemy() -> void:
	var scene_to_spawn: PackedScene
	
	if enemy_pool.is_empty():
		return # No enemies to spawn
	
	scene_to_spawn = enemy_pool.pick_random()
	
	var enemy: Node = scene_to_spawn.instantiate()
	if enemy == null:
		return

	var angle := _rng.randf_range(0.0, TAU)
	var offset := Vector2.RIGHT.rotated(angle) * spawn_radius
	enemy.global_position = player.global_position + offset

	enemy.target = player

	spawn_root.add_child(enemy)
	enemy_spawned.emit(enemy)

func spawn_boss(boss_scene: PackedScene) -> void:
	if not boss_scene or not player:
		return
		
	var boss = boss_scene.instantiate()
	# Spawn boss slightly further away
	var angle := _rng.randf_range(0.0, TAU)
	var offset := Vector2.RIGHT.rotated(angle) * (spawn_radius * 1.5)
	
	boss.global_position = player.global_position + offset
	if "target" in boss:
		boss.target = player
		
	spawn_root.add_child(boss)
	enemy_spawned.emit(boss)
