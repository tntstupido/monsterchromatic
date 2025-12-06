extends Node

@export var spawner: Node # Reference to EnemySpawner
@export var waves: Array[Resource] = [] # Array of WaveDefinition

var _current_wave_index: int = -1
var _game_time: float = 0.0
var _boss_spawned_for_wave: Dictionary = {} # wave_index -> bool

func _process(delta: float) -> void:
	if not spawner:
		return
		
	_game_time += delta
	
	# Find current wave based on time
	var active_wave: Resource = null
	var active_index: int = -1
	
	for i in range(waves.size()):
		var w = waves[i]
		if _game_time >= w.start_time and (_game_time < w.end_time or w.end_time == -1):
			active_wave = w
			active_index = i
			break
			
	if active_wave:
		_apply_wave(active_wave, active_index)

func _apply_wave(wave: Resource, index: int) -> void:
	# Update spawner settings if Changed
	if _current_wave_index != index:
		print("Wave Changed to: ", index)
		_current_wave_index = index
		
		# Update Spawner
		if spawner.get("current_spawn_interval") != null:
			spawner.current_spawn_interval = wave.spawn_interval
		
		if spawner.get("enemy_pool") != null:
			spawner.enemy_pool = wave.enemies
			
	# Check for boss spawn
	if wave.boss_scene and not _boss_spawned_for_wave.get(index, false):
		# Spawn boss at start of wave (or maybe delayed?)
		# For now, immediate.
		print("Spawning Boss for Wave: ", index)
		if spawner.has_method("spawn_boss"):
			spawner.spawn_boss(wave.boss_scene)
		_boss_spawned_for_wave[index] = true
