extends Control

@export var max_distance: float = 100.0

var _start_position: Vector2 = Vector2.ZERO
var _current_touch_index: int = -1
var _input_manager: Node

func _ready() -> void:
	_input_manager = get_node_or_null("/root/InputManager")


func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			if _current_touch_index == -1:
				_current_touch_index = event.index
				_start_position = event.position
		elif event.index == _current_touch_index:
			_reset()
	
	elif event is InputEventScreenDrag:
		if event.index == _current_touch_index:
			_update_input(event.position)


func _update_input(current_position: Vector2) -> void:
	var diff := current_position - _start_position
	var distance := diff.length()
	var vector: Vector2 = diff.normalized() * min(distance / max_distance, 1.0)
	
	if _input_manager:
		_input_manager.set_virtual_move(vector)


func _reset() -> void:
	_current_touch_index = -1
	if _input_manager:
		_input_manager.set_virtual_move(Vector2.ZERO)
