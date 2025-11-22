extends Control

signal vector_changed(vector2)

@export var radius: float = 120.0
@export var deadzone: float = 0.18
@export var return_speed: float = 10.0

var _active_touch: int = -1
var _vector: Vector2 = Vector2.ZERO
var _dragging: bool = false

@onready var _handle: Control = get_node_or_null("%Handle")

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	set_process(true)
	if _handle:
		_handle.position = size * 0.5


func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		_handle_touch(event)
	elif event is InputEventScreenDrag:
		_handle_drag(event)
	elif event is InputEventMouseButton:
		# Desktop fallback for testing with a mouse (left button).
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			_active_touch = 0
			_dragging = true
			_update_vector_from_local(event.position)
		elif not event.pressed and _dragging:
			_reset_touch()
	elif event is InputEventMouseMotion and _dragging:
		_update_vector_from_local(event.position)


func _process(delta: float) -> void:
	if not _dragging and _vector != Vector2.ZERO:
		_set_vector(_vector.move_toward(Vector2.ZERO, return_speed * delta))


func _handle_touch(event: InputEventScreenTouch) -> void:
	if event.pressed:
		if _active_touch == -1 and _is_inside(event.position):
			_active_touch = event.index
			_dragging = true
			_update_vector_from_screen(event.position)
	else:
		if event.index == _active_touch:
			_reset_touch()


func _handle_drag(event: InputEventScreenDrag) -> void:
	if event.index == _active_touch:
		_update_vector_from_screen(event.position)


func _reset_touch() -> void:
	_active_touch = -1
	_dragging = false
	_set_vector(Vector2.ZERO)


func _update_vector_from_screen(screen_position: Vector2) -> void:
	var inv: Transform2D = get_global_transform_with_canvas().affine_inverse()
	var local: Vector2 = inv * screen_position
	_update_vector_from_local(local)


func _update_vector_from_local(local: Vector2) -> void:
	var center: Vector2 = size * 0.5
	var offset: Vector2 = local - center
	var vec: Vector2 = offset / float(max(1.0, radius))

	if vec.length() < deadzone:
		vec = Vector2.ZERO
	elif vec.length() > 1.0:
		vec = vec.normalized()

	_set_vector(vec)


func _set_vector(vec: Vector2) -> void:
	if vec == _vector:
		return

	_vector = vec
	if _handle:
		_handle.position = (size * 0.5) + (vec * radius * 0.6) - (_handle.size * 0.5)
	vector_changed.emit(_vector)


func _is_inside(screen_position: Vector2) -> bool:
	return get_global_rect().has_point(screen_position)
