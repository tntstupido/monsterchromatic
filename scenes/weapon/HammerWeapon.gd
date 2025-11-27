extends "res://scenes/weapon/MeleeWeapon.gd"

@export var min_radius: float = 50.0
@export var max_radius: float = 90.0
@export var wobble_speed: float = 5.0
@export var fixed_starting_rotation: float = 0.0 # Fixed rotation in radians (0 = right)
@export var hit_pause_duration: float = 0.08 # Duration of hitstop on impact

var _time: float = 0.0
var _base_sprite_offset: Vector2
var _base_hitbox_offset: Vector2
var _current_tween: Tween = null

func _ready() -> void:
	super._ready()
	# Set to fixed starting rotation
	rotation = fixed_starting_rotation
	
	# Remember base offsets from scene
	if _sprite:
		_base_sprite_offset = _sprite.position
	if _hitbox:
		for child in _hitbox.get_children():
			if child is Node2D:
				_base_hitbox_offset = child.position
				break

func _perform_attack(_direction: Vector2) -> void:
	# Always spin from fixed starting position, ignore direction
	if _hitbox:
		_hitbox.monitoring = true
		_current_tween = create_tween()
		# Spin 360 degrees and return to starting position
		_current_tween.tween_property(self, "rotation", fixed_starting_rotation + TAU, swing_duration)
		_current_tween.tween_callback(func():
			_hitbox.monitoring = false
			rotation = fixed_starting_rotation # Reset to starting rotation
			_current_tween = null
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
		
		# Scale up then back down (slower, more visible)
		shake_tween.tween_property(_sprite, "scale", _sprite.scale * 1.5, 0.1)
		shake_tween.chain().tween_property(_sprite, "scale", Vector2(0.4, 0.4), 0.1)
		
		# Stronger shake effect (larger random offset)
		var shake_offset = Vector2(randf_range(-15, 15), randf_range(-15, 15))
		var original_pos = _sprite.position
		shake_tween.tween_property(_sprite, "position", original_pos + shake_offset, 0.04)
		shake_tween.chain().tween_property(_sprite, "position", original_pos, 0.04)

func _process(delta: float) -> void:
	super._process(delta)
	
	# Apply wobble effect during attack to create elliptical motion
	if _hitbox and _hitbox.monitoring:
		_time += delta * wobble_speed
		var current_radius = lerp(min_radius, max_radius, (sin(_time) + 1.0) / 2.0)
		
		# Calculate scale factor based on base offset length and current radius
		var base_length = _base_sprite_offset.length()
		var scale_factor = current_radius / base_length if base_length > 0 else 1.0
		
		# Update positions of sprite and hitbox
		if _sprite:
			_sprite.position = _base_sprite_offset * scale_factor
		if _hitbox:
			for child in _hitbox.get_children():
				if child is Node2D:
					child.position = _base_hitbox_offset * scale_factor
