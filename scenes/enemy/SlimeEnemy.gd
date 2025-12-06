extends "res://scenes/enemy/Enemy.gd"

@export var puddle_scene: PackedScene = preload("res://scenes/enemy/SlimePuddle.tscn")
@export var puddle_interval: float = 0.5

var _puddle_timer: float = 0.0

func _process(delta: float) -> void:
	# super._process(delta) # Parent doesn't use process, uses physics_process
	_puddle_timer -= delta
	if _puddle_timer <= 0.0:
		_puddle_timer = puddle_interval
		_spawn_puddle()

func _spawn_puddle() -> void:
	if not puddle_scene:
		return
		
	var puddle = puddle_scene.instantiate()
	puddle.global_position = global_position
	
	# Add to the parent (World/Enemies container) so it doesn't move with the enemy
	get_parent().add_child(puddle)
	# Move to bottom to be under units: z_index -1 handles this, move_to_back is not a valid function on Node
	# if strictly needed: get_parent().move_child(puddle, 0)
