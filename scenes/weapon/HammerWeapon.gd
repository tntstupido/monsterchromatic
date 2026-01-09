extends "res://scenes/weapon/MeleeWeapon.gd"

@export var orbit_radius: float = 70.0
@export var fixed_starting_rotation: float = 0.0 # Fixed rotation in radians (0 = right)
@export var hit_pause_duration: float = 0.08 # Duration of hitstop on impact
@export var anticipation_angle: float = -30.0 # Wind-up angle in degrees
@export var anticipation_duration: float = 0.15 # Wind-up time
@export var trail_color: Color = Color(0.8, 0.8, 0.8, 0.5) # Trail color
@export var trail_length: int = 8 # Number of trail segments

@onready var _sprite: Sprite2D = $Sprite2D
var _current_tween: Tween = null
var _trail_points: Array[Vector2] = []
var _is_attacking: bool = false

func _ready() -> void:
	super._ready()
	# Set to fixed starting rotation
	rotation = fixed_starting_rotation

	# Set fixed orbit radius for sprite and hitbox
	if _sprite:
		var angle = _sprite.position.angle()
		_sprite.position = Vector2.from_angle(angle) * orbit_radius

	if _hitbox:
		for child in _hitbox.get_children():
			if child is CollisionShape2D:
				child.position = Vector2(0, -orbit_radius)
				break

func _perform_attack(_direction: Vector2) -> void:
	_hit_this_swing.clear()
	_trail_points.clear()
	_is_attacking = true

	if _hitbox:
		_hitbox.monitoring = true

		# Create smooth animation with anticipation and easing
		_current_tween = create_tween()

		# Anticipation: Pull back slightly (reversed direction)
		var anticipation_rot = fixed_starting_rotation - deg_to_rad(anticipation_angle)
		_current_tween.tween_property(self, "rotation", anticipation_rot, anticipation_duration).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)

		# Main swing: Fast powerful rotation with ease in-out for natural feel (reversed - counterclockwise)
		_current_tween.tween_property(self, "rotation", fixed_starting_rotation - TAU, swing_duration - anticipation_duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)

		# Finish
		_current_tween.tween_callback(func():
			_on_attack_finished()
			rotation = fixed_starting_rotation
			_current_tween = null
			_is_attacking = false
		)

func _on_body_entered(body: Node) -> void:
	# Call parent to handle damage
	super._on_body_entered(body)

	# Add impact feedback
	if body.is_in_group("enemy"):
		_apply_hit_pause()

func _apply_hit_pause() -> void:
	# Create shake and scale effect without pausing rotation
	if _sprite:
		var shake_tween = create_tween().set_parallel(true)

		# Scale up then back down (impact feel)
		shake_tween.tween_property(_sprite, "scale", _sprite.scale * 1.4, 0.06)
		shake_tween.chain().tween_property(_sprite, "scale", Vector2(0.4, 0.4), 0.08)

		# Shake effect
		var shake_offset = Vector2(randf_range(-12, 12), randf_range(-12, 12))
		var original_pos = _sprite.position
		shake_tween.tween_property(_sprite, "position", original_pos + shake_offset, 0.03)
		shake_tween.chain().tween_property(_sprite, "position", original_pos, 0.05)

func _process(delta: float) -> void:
	super._process(delta)

	# Update trail during attack
	if _is_attacking and _sprite:
		var hammer_global_pos = _sprite.global_position
		_trail_points.append(hammer_global_pos)

		# Limit trail length
		if _trail_points.size() > trail_length:
			_trail_points.pop_front()

		queue_redraw()
	elif _trail_points.size() > 0:
		# Fade out trail after attack
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

		var thickness = 3.0 * alpha
		var start = to_local(_trail_points[i])
		var end = to_local(_trail_points[i + 1])

		draw_line(start, end, color, thickness, true)
