extends "res://scenes/weapon/Weapon.gd"

@export var projectile_speed: float = 700.0
@export var spread_degrees: float = 5.0
@export var projectile_scene: PackedScene
@export var hide_visual_while_flying: bool = false

var _rng := RandomNumberGenerator.new()

func _ready() -> void:
	_rng.randomize()

func _perform_attack(direction: Vector2) -> void:
	var main = get_tree().current_scene
	if not main.has_method("request_projectile"):
		# Fallback if main scene is not what we expect (e.g. testing)
		return

	var spread_rad = deg_to_rad(_rng.randf_range(-spread_degrees, spread_degrees))
	var final_dir = direction.rotated(spread_rad)
	
	if projectile_scene:
		# Custom projectile (e.g. Axe) - bypass default pool for now or handle it
		var projectile = projectile_scene.instantiate()
		projectile.global_position = global_position
		projectile.direction = final_dir
		projectile.speed = projectile_speed
		projectile.damage = damage
		
		# If it's a Boomerang, it might need extra setup, but reset() or properties should handle it.
		# We need to add it to the scene.
		if main.has_method("spawn_projectile"):
			main.spawn_projectile(projectile)
		else:
			main.add_child(projectile)
			
		if projectile.has_method("reset"):
			projectile.reset(global_position, final_dir, projectile_speed, damage)
			
		if hide_visual_while_flying:
			visible = false
			if projectile.has_signal("caught"):
				if not projectile.is_connected("caught", _on_projectile_caught):
					projectile.caught.connect(_on_projectile_caught)
			else:
				if not projectile.is_connected("tree_exited", _on_projectile_caught):
					projectile.tree_exited.connect(_on_projectile_caught)
	else:
		# Default behavior using Main's pool
		main.request_projectile(global_position, final_dir, projectile_speed, damage)


func _on_projectile_caught() -> void:
	visible = true
