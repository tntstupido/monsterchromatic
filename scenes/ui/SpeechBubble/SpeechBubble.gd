extends Node2D

@onready var _label: Label = %Label
@onready var _margin_container: MarginContainer = %MarginContainer

@export var bg_color: Color = Color("f0ece2") # Off-white/Beige
@export var border_color: Color = Color("1a1a1a") # Near black
@export var border_width: float = 4.0 # Slightly thicker
@export var shake_intensity: float = 2.5 # More shaky
@export var default_duration: float = 2.5

var _rect: Rect2
var _points: PackedVector2Array
var _tail_points: PackedVector2Array
var _shaky_points: PackedVector2Array
var _shaky_tail: PackedVector2Array
var _time: float = 0.0
var _active: bool = false

func _ready() -> void:
	modulate.a = 0.0
	set_process(true)

func _process(delta: float) -> void:
	if not _active: return
	_time += delta * 15.0 # Speed of shaking
	queue_redraw()

var _current_tween: Tween = null
var _auto_hide: bool = true

func display_text(text: String, duration: float = default_duration, auto_hide: bool = true) -> void:
	_auto_hide = auto_hide
	_label.text = text

	# Kill existing tween if any
	if _current_tween:
		_current_tween.kill()

	# Wait for layout update
	await get_tree().process_frame

	var size = _margin_container.get_combined_minimum_size()
	if size.x < 60: size.x = 60 # Minimum width
	if size.y < 30: size.y = 30 # Minimum height

	_rect = Rect2(-size.x / 2.0, -size.y - 50, size.x, size.y)
	_margin_container.size = size
	_margin_container.position = _rect.position

	# Pre-calculate base points for the bubble
	_points = _get_rounded_rect_points(_rect, 10.0)

	# Pre-calculate tail points
	var tail_width = 15.0
	_tail_points = PackedVector2Array([
		Vector2(-tail_width, _rect.position.y + _rect.size.y),
		Vector2(0, -30), # Tip of the tail
		Vector2(tail_width, _rect.position.y + _rect.size.y)
	])

	_active = true

	# Animate in
	_current_tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	_current_tween.tween_property(self, "modulate:a", 1.0, 0.2)

	if _auto_hide:
		_current_tween.tween_interval(duration)
		_current_tween.tween_property(self, "modulate:a", 0.0, 0.3)
		_current_tween.finished.connect(queue_free)

func _draw() -> void:
	if not _active: return
	
	_shaky_points.clear()
	for i in range(_points.size()):
		var p = _points[i]
		# Add noise based on time and index
		var offset = Vector2(
			sin(_time + i) * randf_range(0, shake_intensity),
			cos(_time * 0.8 + i * 1.5) * randf_range(0, shake_intensity)
		)
		_shaky_points.append(p + offset)
		
	_shaky_tail.clear()
	for i in range(_tail_points.size()):
		var p = _tail_points[i]
		var offset = Vector2(
			sin(_time + i + 10) * randf_range(0, shake_intensity),
			cos(_time * 0.7 + i * 1.3) * randf_range(0, shake_intensity)
		)
		_shaky_tail.append(p + offset)

	# Draw Background (Polygon)
	# Drawing two polygons for simplicity, they might overlap slightly
	draw_colored_polygon(_shaky_points, bg_color)
	draw_colored_polygon(_shaky_tail, bg_color)
	
	# Draw Borders
	# Close the loop for the bubble
	var border_points = Array(_shaky_points)
	border_points.append(_shaky_points[0])
	draw_polyline(PackedVector2Array(border_points), border_color, border_width, true)
	
	# Draw Tail border (only the two "open" sides)
	draw_line(_shaky_tail[0], _shaky_tail[1], border_color, border_width, true)
	draw_line(_shaky_tail[1], _shaky_tail[2], border_color, border_width, true)

func _get_rounded_rect_points(rect: Rect2, radius: float) -> PackedVector2Array:
	var pts = PackedVector2Array()
	var detail = 4 # Number of points per corner
	
	# Top Right
	for i in range(detail + 1):
		var angle = - PI / 2 + (PI / 2) * i / detail
		pts.append(rect.position + Vector2(rect.size.x - radius, radius) + Vector2(cos(angle), sin(angle)) * radius)
	
	# Bottom Right
	for i in range(detail + 1):
		var angle = 0 + (PI / 2) * i / detail
		pts.append(rect.position + Vector2(rect.size.x - radius, rect.size.y - radius) + Vector2(cos(angle), sin(angle)) * radius)
		
	# Bottom Left
	for i in range(detail + 1):
		var angle = PI / 2 + (PI / 2) * i / detail
		pts.append(rect.position + Vector2(radius, rect.size.y - radius) + Vector2(cos(angle), sin(angle)) * radius)
		
	# Top Left
	for i in range(detail + 1):
		var angle = PI + (PI / 2) * i / detail
		pts.append(rect.position + Vector2(radius, radius) + Vector2(cos(angle), sin(angle)) * radius)
		
	return pts
