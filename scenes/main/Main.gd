extends Node2D

@export var player_scene: PackedScene = preload("res://scenes/player/Player.tscn")
@export var enemy_scene: PackedScene = preload("res://scenes/enemy/Enemy.tscn")
@export var projectile_scene: PackedScene = preload("res://scenes/projectile/Projectile.tscn")

@onready var world: Node2D = %World
@onready var enemies: Node = %Enemies
@onready var projectiles: Node = %Projectiles
@onready var spawner: Node = %EnemySpawner
@onready var hud: CanvasLayer = %HUD
@onready var camera: Camera2D = %Camera2D

# Preload types to ensure they are available
const ObjectPoolScript = preload("res://scenes/common/ObjectPool.gd")
const ProjectileScript = preload("res://scenes/projectile/Projectile.gd")

var projectile_pool: ObjectPool
var player
var elapsed: float = 0.0
var wave: int = 1


func _ready() -> void:
	if ExperienceManager:
		ExperienceManager.level_up.connect(_on_level_up)
		
	_setup_pool()
	_setup_player()
	_setup_spawner()
	_setup_wave_manager()
	hud.update_wave(wave)
	hud.update_time(elapsed)

func _setup_wave_manager() -> void:
	var wm_scene = preload("res://scenes/spawner/WaveManager.tscn")
	var wm = wm_scene.instantiate()
	add_child(wm)
	wm.spawner = spawner
	
	# Load waves
	var w1 = load("res://scenes/levels/wave_1.tres")
	var w2 = load("res://scenes/levels/wave_2.tres")
	var boss = load("res://scenes/levels/wave_boss.tres")
	
	var wave_list: Array[Resource] = [w1, w2, boss]
	wm.waves = wave_list


func _process(delta: float) -> void:
	elapsed += delta
	hud.update_time(elapsed)

	var new_wave := 1 + int(elapsed / 45.0)
	if new_wave != wave:
		wave = new_wave
		hud.update_wave(wave)

	if player:
		camera.position = player.global_position


func _setup_pool() -> void:
	projectile_pool = ObjectPoolScript.new()
	projectile_pool.scene = projectile_scene
	projectile_pool.initial_size = 50
	projectile_pool.name = "ProjectilePool"
	projectiles.add_child(projectile_pool)


func _setup_player() -> void:
	if not player_scene:
		push_error("Player scene missing")
		return

	player = world.get_node_or_null("Player")
	if not player:
		player = player_scene.instantiate()
		world.add_child(player)

	player.main = self
	# player.projectile_scene = projectile_scene # Deprecated, handled by Weapon
	player.health_changed.connect(_on_player_health_changed)
	player.died.connect(_on_player_died)
	hud.update_health(player.max_health, player.max_health)
	camera.position = player.position
	camera.top_level = true
	camera.make_current()


func _setup_spawner() -> void:
	# spawner.enemy_scene = enemy_scene # Deprecated: Managed by WaveManager
	spawner.spawn_root = enemies
	spawner.player = player
	spawner.enemy_spawned.connect(_on_enemy_spawned)


func _on_enemy_spawned(enemy: Node) -> void:
	if enemy.has_signal("died"):
		enemy.died.connect(_on_enemy_died)


func _on_enemy_died(enemy: Node) -> void:
	if is_instance_valid(enemy) and not enemy.is_queued_for_deletion():
		enemy.queue_free()


func _on_player_health_changed(current: float, maximum: float) -> void:
	hud.update_health(current, maximum)


func _on_level_up(new_level: int) -> void:
	# Ignore level 1 (start)
	if new_level <= 1:
		return
		
	var screen_scene = load("res://scenes/ui/LevelUpScreen.tscn")
	if screen_scene:
		var screen = screen_scene.instantiate()
		add_child(screen)


func _on_player_died() -> void:
	# get_tree().paused = true # Removed to allow scene transition
	get_tree().change_scene_to_file("res://scenes/ui/GameOver.tscn")


func spawn_projectile(projectile: Node) -> void:
	# Deprecated: Player instantiates projectile. 
	# We should change Player to request projectile from pool.
	# For now, if passed projectile is not in pool, just add it.
	projectiles.add_child(projectile)


func request_projectile(spawn_pos: Vector2, direction: Vector2, speed: float, damage: float) -> void:
	var projectile = projectile_pool.get_instance()
	if not projectile:
		return
		
	projectile.pool = projectile_pool
	projectile.reset(spawn_pos, direction, speed, damage)


func get_closest_enemy_direction(from_position: Vector2) -> Vector2:
	var closest_dir := Vector2.ZERO
	var closest_distance := INF

	for enemy in enemies.get_children():
		if not enemy is Node2D:
			continue
		var dist := from_position.distance_to(enemy.global_position)
		if dist < closest_distance:
			closest_distance = dist
			closest_dir = (enemy.global_position - from_position).normalized()

	return closest_dir


func _on_projectile_freed() -> void:
	pass


# Debug Console support methods
func get_random_enemy_scene() -> PackedScene:
	# List of all available enemy types
	var enemy_scenes = [
		preload("res://scenes/enemy/Enemy.tscn"),        # Basic enemy
		preload("res://scenes/enemy/SlimeEnemy.tscn"),   # Slime
		preload("res://scenes/enemy/BatEnemy.tscn"),     # Bat
		preload("res://scenes/enemy/FastEnemy.tscn"),    # Fast enemy
	]
	return enemy_scenes[randi() % enemy_scenes.size()]


func spawn_enemy(scene: PackedScene, spawn_pos: Vector2) -> Node:
	if not scene:
		return null

	var enemy = scene.instantiate()
	enemies.add_child(enemy)
	enemy.global_position = spawn_pos

	# Connect signals just like in _on_enemy_spawned
	if enemy.has_signal("died"):
		enemy.died.connect(_on_enemy_died)

	return enemy
