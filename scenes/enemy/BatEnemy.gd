extends "res://scenes/enemy/Enemy.gd"

@export var zigzag_frequency: float = 4.0
@export var zigzag_amplitude: float = 1.5 # Multiplier for perpendicular force

var _time_offset: float = 0.0

func _ready() -> void:
	super._ready()
	_time_offset = randf() * 100.0

func _physics_process(delta: float) -> void:
	# Custom Movement Logic
	if target:
		var dir_to_target = (target.global_position - global_position).normalized()
		
		# ZigZag Calculation
		var time = Time.get_ticks_msec() / 1000.0 + _time_offset
		var sine_val = sin(time * zigzag_frequency)
		
		# Perpendicular vector (rotate 90 deg)
		var perp_dir = Vector2(-dir_to_target.y, dir_to_target.x) * sine_val * zigzag_amplitude
		
		# Combine direct approach with side-to-side wobble
		# We normalize the result to keep speed consistent, but bias it forward
		# Actually, adding vectors works well.
		var final_dir = (dir_to_target + perp_dir).normalized()
		
		velocity = velocity.move_toward(final_dir * move_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)

	# Update facing and wobble
	_update_facing()
	_update_wobble(delta)


	# Collision Logic (Copied from Enemy.gd because we overrode _physics_process)
	_contact_timer = max(0.0, _contact_timer - delta)
	var collision := move_and_collide(velocity * delta)

	if collision and collision.get_collider() and collision.get_collider().is_in_group("player"):
		_hit_player(collision.get_collider())
