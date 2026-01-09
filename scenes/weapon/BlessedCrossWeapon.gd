extends "res://scenes/weapon/RangedWeapon.gd"

# BlessedCross fires 4 projectiles in cardinal directions (0°, 90°, 180°, 270°)
@export var projectile_count: int = 4

func _perform_attack(_direction: Vector2) -> void:
	var main = get_tree().current_scene
	if not main.has_method("spawn_projectile"):
		return

	if not projectile_scene:
		return

	# Fire projectiles in 4 cardinal directions
	var angle_step = 360.0 / projectile_count  # 90 degrees for 4 projectiles

	for i in range(projectile_count):
		var angle_deg = i * angle_step
		var angle_rad = deg_to_rad(angle_deg)
		var fire_dir = Vector2.RIGHT.rotated(angle_rad)

		var projectile = projectile_scene.instantiate()
		projectile.global_position = global_position
		projectile.direction = fire_dir
		projectile.speed = projectile_speed
		projectile.damage = damage

		main.spawn_projectile(projectile)

		if projectile.has_method("reset"):
			projectile.reset(global_position, fire_dir, projectile_speed, damage)
