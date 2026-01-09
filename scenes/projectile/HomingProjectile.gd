extends Projectile

@export var homing_strength: float = 3.0  # How strongly it turns toward target
@export var explosion_radius: float = 40.0
@export var explosion_damage_percent: float = 0.75  # Explosion does 75% of main damage
@export var detection_range: float = 400.0  # Range to detect enemies

var _target: Node2D = null
var _has_exploded: bool = false

func _ready() -> void:
	super._ready()

func reset(pos: Vector2, dir: Vector2, spd: float, dmg: float) -> void:
	super.reset(pos, dir, spd, dmg)
	_target = null
	_has_exploded = false
	_find_nearest_enemy()

func _process(delta: float) -> void:
	# Update lifetime
	life_time -= delta
	if life_time <= 0.0:
		_explode()
		return

	# Check if target is still valid
	if _target and not is_instance_valid(_target):
		_target = null

	# Find new target if we don't have one
	if not _target:
		_find_nearest_enemy()

	# Home toward target
	if _target and is_instance_valid(_target):
		var target_dir = (_target.global_position - global_position).normalized()
		# Smoothly turn toward target
		direction = direction.lerp(target_dir, homing_strength * delta).normalized()

	# Move forward
	position += direction * speed * delta

func _find_nearest_enemy() -> void:
	var enemies = get_tree().get_nodes_in_group("enemy")
	var nearest_dist = detection_range
	var nearest_enemy: Node2D = null

	for enemy in enemies:
		if not is_instance_valid(enemy):
			continue

		var dist = global_position.distance_to(enemy.global_position)
		if dist < nearest_dist:
			nearest_dist = dist
			nearest_enemy = enemy

	_target = nearest_enemy

func _on_body_entered(body: Node) -> void:
	if not body or body == self or _has_exploded:
		return

	if body.is_in_group("enemy"):
		_explode()

func _explode() -> void:
	if _has_exploded:
		return

	_has_exploded = true

	# Deal direct damage to hit enemy
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("enemy") and body.has_method("take_damage"):
			body.take_damage(damage)

	# Deal AOE explosion damage (percentage of main damage)
	var explosion_dmg = damage * explosion_damage_percent
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		if not is_instance_valid(enemy):
			continue

		var dist = global_position.distance_to(enemy.global_position)
		if dist <= explosion_radius:
			if enemy.has_method("take_damage"):
				enemy.take_damage(explosion_dmg)

	# Play hit sound
	if hit_sound:
		AudioManager.play_sound(hit_sound, global_position)

	# Spawn visual explosion effect
	_spawn_explosion_effect()

	_return_to_pool()

func _spawn_explosion_effect() -> void:
	# Create explosion particles with ring-like pattern
	var explosion = CPUParticles2D.new()
	explosion.z_index = 10  # Draw on top
	explosion.global_position = global_position
	explosion.one_shot = true
	explosion.explosiveness = 0.8  # Slightly less instant for wave effect
	explosion.amount = 50
	explosion.lifetime = 0.5
	explosion.speed_scale = 1.5
	explosion.preprocess = 0.0
	explosion.local_coords = false

	# Ring emission settings
	explosion.emission_shape = CPUParticles2D.EMISSION_SHAPE_SPHERE
	explosion.emission_sphere_radius = explosion_radius * 0.8  # Start near edge

	# Movement - expand outward
	explosion.direction = Vector2.ZERO
	explosion.spread = 180.0
	explosion.gravity = Vector2.ZERO
	explosion.initial_velocity_min = 50.0
	explosion.initial_velocity_max = 100.0
	explosion.radial_accel_min = -50.0
	explosion.radial_accel_max = -100.0

	# Appearance
	explosion.scale_amount_min = 0.8
	explosion.scale_amount_max = 1.5
	explosion.color = Color(0.8, 0.3, 1.0, 1.0)  # Bright purple

	# Add to scene (add to main scene, not root)
	var main = get_tree().current_scene
	if main:
		main.add_child(explosion)
	else:
		get_tree().root.add_child(explosion)
	explosion.emitting = true

	# Create visible ring using Node2D
	var ring = ExplosionRing.new()
	ring.z_index = 10
	ring.max_radius = explosion_radius
	ring.global_position = global_position
	if main:
		main.add_child(ring)
	else:
		get_tree().root.add_child(ring)

	# Animate the ring with longer duration for visibility
	var tween = get_tree().create_tween()
	tween.tween_property(ring, "progress", 1.0, 0.4)
	tween.tween_callback(func():
		if is_instance_valid(ring):
			ring.queue_free()
		if is_instance_valid(explosion):
			explosion.queue_free()
	)

func _create_fade_gradient() -> Gradient:
	var gradient = Gradient.new()
	gradient.set_color(0, Color(0.8, 0.3, 1.0, 1.0))  # Bright purple
	gradient.set_color(1, Color(0.4, 0.1, 0.6, 0.0))  # Fade to transparent
	return gradient


# Custom class for drawing explosion ring
class ExplosionRing extends Node2D:
	var progress: float = 0.0:
		set(value):
			progress = value
			queue_redraw()
	var max_radius: float = 100.0

	func _draw() -> void:
		var current_radius = max_radius * progress
		var alpha = 1.0 - (progress * 0.5)  # Fade slower

		# Draw inner filled circle (semi-transparent)
		var fill_color = Color(0.8, 0.3, 1.0, alpha * 0.4)
		draw_circle(Vector2.ZERO, current_radius, fill_color)

		# Draw bright outer ring (thicker and brighter)
		var ring_color = Color(1.0, 0.5, 1.0, alpha * 0.9)
		draw_arc(Vector2.ZERO, current_radius, 0, TAU, 64, ring_color, 8.0, true)

		# Draw inner ring for extra visibility
		if current_radius > 10:
			var inner_color = Color(0.9, 0.4, 1.0, alpha * 0.6)
			draw_arc(Vector2.ZERO, current_radius * 0.7, 0, TAU, 48, inner_color, 4.0, true)
