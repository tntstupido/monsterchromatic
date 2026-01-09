extends "res://scenes/weapon/RangedWeapon.gd"

# Cursed Skull weapon with scaling explosion radius
@export var base_explosion_radius: float = 120.0
@export var max_explosion_radius: float = 200.0
@export var radius_growth_per_level: float = 10.0

var current_explosion_radius: float = 120.0

func _ready() -> void:
	super._ready()
	current_explosion_radius = base_explosion_radius

func level_up() -> void:
	super.level_up()

	# Increase explosion radius with each level (capped at max)
	current_explosion_radius = min(
		base_explosion_radius + (level - 1) * radius_growth_per_level,
		max_explosion_radius
	)

	print(weapon_name, " explosion radius increased to ", current_explosion_radius, "px")

func _perform_attack(direction: Vector2) -> void:
	var main = get_tree().current_scene
	if not main.has_method("spawn_projectile"):
		return

	if not projectile_scene:
		return

	var projectile = projectile_scene.instantiate()
	projectile.global_position = global_position
	projectile.direction = direction
	projectile.speed = projectile_speed
	projectile.damage = damage

	# Set explosion radius if projectile supports it
	if "explosion_radius" in projectile:
		projectile.explosion_radius = current_explosion_radius

	main.spawn_projectile(projectile)

	if projectile.has_method("reset"):
		projectile.reset(global_position, direction, projectile_speed, damage)
