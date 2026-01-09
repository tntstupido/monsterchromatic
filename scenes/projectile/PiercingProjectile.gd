extends Projectile

@export var trail_color: Color = Color(1.0, 0.9, 0.3, 0.5)  # Golden glow
@export var trail_length: int = 8
@export var rotation_speed: float = 10.0  # Degrees per second for spinning

var _trail_points: Array[Vector2] = []

func _ready() -> void:
	super._ready()

func reset(pos: Vector2, dir: Vector2, spd: float, dmg: float) -> void:
	super.reset(pos, dir, spd, dmg)
	_trail_points.clear()

func _process(delta: float) -> void:
	super._process(delta)

	# Rotate the cross as it flies
	rotation += deg_to_rad(rotation_speed) * delta

	# Update trail
	_trail_points.append(global_position)
	if _trail_points.size() > trail_length:
		_trail_points.pop_front()

	queue_redraw()

func _draw() -> void:
	if _trail_points.size() < 2:
		return

	# Draw trail with fading alpha
	for i in range(_trail_points.size() - 1):
		var alpha = float(i) / float(_trail_points.size())
		var color = trail_color
		color.a = trail_color.a * alpha

		var thickness = 2.0 * alpha
		var start = to_local(_trail_points[i])
		var end = to_local(_trail_points[i + 1])

		draw_line(start, end, color, thickness, true)
