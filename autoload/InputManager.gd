extends Node

## Holds virtual joystick state and provides unified access for mobile + desktop controls.

var _virtual_move: Vector2 = Vector2.ZERO
var _virtual_aim: Vector2 = Vector2.ZERO
var _keyboard_enabled := true

func set_virtual_move(vec: Vector2) -> void:
	_virtual_move = vec


func set_virtual_aim(vec: Vector2) -> void:
	_virtual_aim = vec


func get_move_vector() -> Vector2:
	var result := _virtual_move
	if result == Vector2.ZERO and _keyboard_enabled:
		result = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return result.limit_length(1.0)


func get_aim_vector() -> Vector2:
	var result := _virtual_aim
	if result == Vector2.ZERO and _keyboard_enabled:
		result = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	return result.limit_length(1.0)


func enable_keyboard(value: bool) -> void:
	_keyboard_enabled = value
