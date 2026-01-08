extends Node2D

@export var prop_scenes: Array[PackedScene] = [
	preload("res://scenes/environment/foliage/Foliage_1.tscn"),
	preload("res://scenes/environment/foliage/Foliage_2.tscn"),
	preload("res://scenes/environment/foliage/Foliage_3.tscn"),
	preload("res://scenes/environment/foliage/Foliage_4.tscn"),
	preload("res://scenes/environment/Headstone.tscn")
]

@export var chunk_size: float = 1200.0 # Size of each spawn chunk in pixels
@export var props_per_chunk: int = 5 # How many props to spawn in a new chunk
@export var spawn_radius_chunks: int = 2 # How many chunks around the player to check

var _spawned_chunks: Dictionary = {} # Store keys as "x_y" strings
var _player: Node2D

func _ready() -> void:
	# Attempt to find the player
	_player = get_tree().get_first_node_in_group("player")
	if not _player:
		# Fallback: Find in parent scene
		_player = get_parent().get_node_or_null("Player")
	
	# Initial spawn
	_check_and_spawn_chunks()

func _process(_delta: float) -> void:
	if not _player:
		_player = get_tree().get_first_node_in_group("player")
		return
		
	_check_and_spawn_chunks()

func _check_and_spawn_chunks() -> void:
	if not _player: return
	
	# Get player's current chunk coordinates
	var p_pos = _player.global_position
	var p_chunk_x = int(floor(p_pos.x / chunk_size))
	var p_chunk_y = int(floor(p_pos.y / chunk_size))
	
	# Check a grid of chunks around the player
	for x in range(p_chunk_x - spawn_radius_chunks, p_chunk_x + spawn_radius_chunks + 1):
		for y in range(p_chunk_y - spawn_radius_chunks, p_chunk_y + spawn_radius_chunks + 1):
			var chunk_key = str(x) + "_" + str(y)
			if not _spawned_chunks.has(chunk_key):
				_spawn_chunk(x, y)
				_spawned_chunks[chunk_key] = true

func _spawn_chunk(chunk_x: int, chunk_y: int) -> void:
	if prop_scenes.is_empty(): return
	
	# Use a consistent seed for this chunk so we could potentially re-generate it
	# (Though we store it in Dictionary, seeding helps with determinism)
	seed(chunk_x * 73856093 ^ chunk_y * 19349663)
	
	var chunk_origin = Vector2(chunk_x * chunk_size, chunk_y * chunk_size)
	
	for i in range(props_per_chunk):
		var scene = prop_scenes.pick_random()
		var prop = scene.instantiate()
		
		# Random position within the chunk
		var random_pos = Vector2(
			randf_range(0, chunk_size),
			randf_range(0, chunk_size)
		)
		
		# Global position
		prop.position = chunk_origin + random_pos
		
		# Variety
		prop.scale *= randf_range(0.8, 1.3)
		prop.rotation_degrees = randf_range(-10, 10)
		
		add_child(prop)
	
	# Reset seed to random for other systems
	randomize()
