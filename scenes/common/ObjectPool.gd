class_name ObjectPool
extends Node

@export var scene: PackedScene
@export var initial_size: int = 20
@export var expand_allowed: bool = true

var _pool: Array[Node] = []

func _ready() -> void:
	if not scene:
		push_error("ObjectPool: No scene assigned!")
		return
		
	for i in range(initial_size):
		var instance = _create_instance()
		_pool.append(instance)


func get_instance() -> Node:
	if _pool.is_empty():
		if expand_allowed:
			return _create_instance()
		else:
			push_warning("ObjectPool: Pool empty and expansion not allowed.")
			return null
			
	var instance = _pool.pop_back()
	if not is_instance_valid(instance):
		# Handle case where instance might have been freed externally
		return get_instance()
		
	instance.visible = true
	instance.process_mode = Node.PROCESS_MODE_INHERIT
	return instance


func return_instance(instance: Node) -> void:
	if not is_instance_valid(instance):
		return
		
	instance.visible = false
	instance.process_mode = Node.PROCESS_MODE_DISABLED
	
	# Reset position to avoid visual glitches if reused immediately
	if instance is Node2D:
		instance.global_position = Vector2(-10000, -10000)
		
	_pool.append(instance)


func _create_instance() -> Node:
	var instance = scene.instantiate()
	# We add it to the tree so it's ready, but hide/disable it
	add_child(instance)
	instance.visible = false
	instance.process_mode = Node.PROCESS_MODE_DISABLED
	return instance
