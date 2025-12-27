extends Node2D

@export var prop_scenes: Array[PackedScene] = [
	preload("res://scenes/environment/ScaryTree.tscn"),
	preload("res://scenes/environment/Headstone.tscn")
]
@export var spawn_count: int = 40
@export var spawn_radius: float = 2000.0
@export var min_distance_from_center: float = 200.0

func _ready() -> void:
	# Randomly scatter props
	for i in range(spawn_count):
		spawn_random_prop()

func spawn_random_prop() -> void:
	if prop_scenes.is_empty(): return
	
	var scene = prop_scenes.pick_random()
	var prop = scene.instantiate()
	
	# Random position
	var angle = randf() * TAU
	var dist = randf_range(min_distance_from_center, spawn_radius)
	var pos = Vector2(cos(angle), sin(angle)) * dist
	
	prop.position = pos
	# Slight variation in scale and rotation for variety
	prop.scale *= randf_range(0.8, 1.3)
	prop.rotation_degrees = randf_range(-10, 10)
	
	add_child(prop)
