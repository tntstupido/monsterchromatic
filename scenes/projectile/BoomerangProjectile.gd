extends Projectile

@export var max_distance: float = 150.0
@export var return_speed: float = 400.0
@export var rotation_speed: float = 15.0
@export var trail_color: Color = Color(0.8, 0.8, 0.8, 0.5)
@export var trail_length: int = 10

enum State {FLYING_OUT, RETURNING}
var _state: int = State.FLYING_OUT
var _start_pos: Vector2
var _target: Node2D
var _trail_points: Array[Vector2] = []

signal caught

func _ready() -> void:
	super._ready()
	_start_pos = global_position

func reset(pos: Vector2, dir: Vector2, spd: float, dmg: float) -> void:
	super.reset(pos, dir, spd, dmg)
	_state = State.FLYING_OUT
	_start_pos = pos
	_trail_points.clear()
	# Find player to return to
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		_target = players[0]

func _process(delta: float) -> void:
	# Smooth spinning with ease in/out based on state
	var spin_multiplier = 1.0
	if _state == State.RETURNING:
		spin_multiplier = 1.5  # Spin faster when returning
	rotation += rotation_speed * delta * spin_multiplier

	# Update trail
	_trail_points.append(global_position)
	if _trail_points.size() > trail_length:
		_trail_points.pop_front()
	queue_redraw()

	match _state:
		State.FLYING_OUT:
			position += direction * speed * delta
			if global_position.distance_to(_start_pos) >= max_distance:
				_state = State.RETURNING

		State.RETURNING:
			if is_instance_valid(_target):
				var dir_to_target = (_target.global_position - global_position).normalized()
				position += dir_to_target * return_speed * delta

				if global_position.distance_to(_target.global_position) < 20.0:
					_return_to_pool()
			else:
				# Target lost, just disappear
				_return_to_pool()

	# Re-implementing base logic minus movement:
	life_time -= delta
	if life_time <= 0.0:
		_return_to_pool()

func _draw() -> void:
	if _trail_points.size() < 2:
		return

	# Draw trail with fading alpha
	for i in range(_trail_points.size() - 1):
		var alpha = float(i) / float(_trail_points.size())
		var color = trail_color
		color.a = trail_color.a * alpha

		var thickness = 2.5 * alpha
		var start = to_local(_trail_points[i])
		var end = to_local(_trail_points[i + 1])

		draw_line(start, end, color, thickness, true)

func _return_to_pool() -> void:
	emit_signal("caught")
	if pool:
		pool.return_instance(self)
	else:
		queue_free()
