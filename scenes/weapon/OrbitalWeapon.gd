class_name OrbitalWeapon
extends Weapon

@export var orbit_radius: float = 80.0
@export var rotation_speed: float = 180.0  # degrees per second
@export var num_orbitals: int = 3
@export var orbital_scene: PackedScene

var _orbitals: Array[Node2D] = []
var _current_angle: float = 0.0

func _ready() -> void:
	# Center the orbital weapon on the player sprite center
	# Sprite is at (0, -64), Muzzle is at (30, -41) relative to Visual node
	# So we need to offset by (-30, -23) to center on sprite
	position = Vector2(-30, -23)
	_spawn_orbitals()

func _spawn_orbitals() -> void:
	# Clear existing orbitals
	for orbital in _orbitals:
		if is_instance_valid(orbital):
			orbital.queue_free()
	_orbitals.clear()

	# Spawn new orbitals
	if not orbital_scene:
		push_error("OrbitalWeapon: orbital_scene is not set!")
		return

	var angle_step = 360.0 / num_orbitals
	for i in range(num_orbitals):
		var orbital = orbital_scene.instantiate()
		add_child(orbital)
		_orbitals.append(orbital)

		# Set initial position
		var angle_rad = deg_to_rad(i * angle_step)
		orbital.position = Vector2(cos(angle_rad), sin(angle_rad)) * orbit_radius

		# Configure damage if the orbital has the property
		if "damage" in orbital:
			orbital.damage = damage

func _process(delta: float) -> void:
	super._process(delta)

	# Rotate orbitals
	_current_angle += rotation_speed * delta
	if _current_angle >= 360.0:
		_current_angle -= 360.0

	# Update orbital positions
	var angle_step = 360.0 / num_orbitals
	for i in range(_orbitals.size()):
		if not is_instance_valid(_orbitals[i]):
			continue

		var angle_rad = deg_to_rad(_current_angle + (i * angle_step))
		_orbitals[i].position = Vector2(cos(angle_rad), sin(angle_rad)) * orbit_radius

func level_up() -> void:
	super.level_up()

	# Increase number of orbitals every other level
	if level % 2 == 0:
		num_orbitals += 1
		_spawn_orbitals()

	# Increase orbit radius (5% per level)
	orbit_radius *= 1.05

	# Increase rotation speed (3% per level for faster orbiting)
	rotation_speed *= 1.03

	# Update damage for all orbitals (damage is already increased by super.level_up())
	for orbital in _orbitals:
		if is_instance_valid(orbital) and "damage" in orbital:
			orbital.damage = damage

# Override attack - orbitals are always active, no manual attack needed
func attack(_direction: Vector2) -> void:
	pass
