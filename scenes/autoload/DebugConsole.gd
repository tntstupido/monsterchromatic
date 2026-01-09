extends Node

# Debug Console for testing and balancing
# Enable/disable with project setting or compile flag

var _enabled: bool = true  # Set to false for production builds
var _god_mode: bool = false
var _verbose: bool = false  # Toggle with F8 - reduces console spam

func _ready() -> void:
	if _verbose:
		print("[DEBUG] Debug Console initialized")
		print("[DEBUG] F1 - Toggle God Mode")
		print("[DEBUG] F2 - Level Up Player")
		print("[DEBUG] F3 - Spawn 10 Enemies")
		print("[DEBUG] F4 - Add Random Weapon")
		print("[DEBUG] F5 - Heal Player")
		print("[DEBUG] F6 - Show Weapon Stats")
		print("[DEBUG] F7 - Toggle Debug Overlay")
		print("[DEBUG] F8 - Toggle Verbose Mode")

func _input(event: InputEvent) -> void:
	if not _enabled:
		return

	if event is InputEventKey and event.pressed and not event.echo:
		match event.keycode:
			KEY_F1:
				_toggle_god_mode()
			KEY_F2:
				_level_up_player()
			KEY_F3:
				_spawn_enemies(10)
			KEY_F4:
				_add_random_weapon()
			KEY_F5:
				_heal_player()
			KEY_F6:
				_print_weapon_stats()
			KEY_F7:
				_toggle_debug_overlay()
			KEY_F8:
				_toggle_verbose()

func _toggle_god_mode() -> void:
	_god_mode = not _god_mode
	var player = get_tree().get_first_node_in_group("player")
	if player:
		if _verbose:
			print("[DEBUG] God Mode: ", "ON" if _god_mode else "OFF")
		# For now, just heal to max and increase health
		if _god_mode:
			player.max_health = 9999.0
			player.heal(9999.0)
		else:
			player.max_health = 100.0

func _level_up_player() -> void:
	# XP system is managed by ExperienceManager autoload
	if ExperienceManager and ExperienceManager.has_method("add_experience"):
		ExperienceManager.add_experience(1000)
		if _verbose:
			print("[DEBUG] Added 1000 XP - Current Level: ", ExperienceManager.current_level)
	else:
		if _verbose:
			print("[DEBUG] ExperienceManager not found!")

func _spawn_enemies(count: int = 10) -> void:
	var main = get_tree().current_scene
	if not main or not main.has_method("spawn_enemy"):
		print("[DEBUG] Main scene doesn't have spawn_enemy method!")
		return

	var player = get_tree().get_first_node_in_group("player")
	if not player:
		print("[DEBUG] Player not found!")
		return

	# Spawn enemies in a circle around player
	for i in range(count):
		var angle = (float(i) / count) * TAU
		var offset = Vector2(cos(angle), sin(angle)) * 200.0
		var spawn_pos = player.global_position + offset

		# Get random enemy type and spawn it
		if main.has_method("get_random_enemy_scene") and main.has_method("spawn_enemy"):
			var enemy_scene = main.get_random_enemy_scene()
			if enemy_scene:
				main.spawn_enemy(enemy_scene, spawn_pos)

	print("[DEBUG] Spawned ", count, " enemies")

func _add_random_weapon() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if not player or not player.has_method("add_weapon"):
		print("[DEBUG] Player not found or doesn't have add_weapon method!")
		return

	# List of available weapons
	var weapons = [
		preload("res://scenes/weapon/Hammer.tscn"),
		preload("res://scenes/weapon/Axe.tscn"),
		preload("res://scenes/weapon/BlessedCross.tscn"),
		preload("res://scenes/weapon/CursedSkull.tscn"),
		preload("res://scenes/weapon/PrayerBeads.tscn"),
	]

	var random_weapon = weapons[randi() % weapons.size()]
	player.add_weapon(random_weapon)
	print("[DEBUG] Added random weapon")

func _heal_player() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player and player.has_method("heal"):
		player.heal(100.0)
		print("[DEBUG] Healed player to full")

func _print_weapon_stats() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if not player:
		print("[DEBUG] Player not found!")
		return

	if "weapons" not in player:
		print("[DEBUG] Player has no weapons array!")
		return

	print("\n[DEBUG] === WEAPON STATS ===")
	for weapon in player.weapons:
		if not is_instance_valid(weapon):
			continue

		var weapon_name = weapon.weapon_name if "weapon_name" in weapon else weapon.name
		var weapon_level = weapon.level if "level" in weapon else 1
		var weapon_damage = weapon.damage if "damage" in weapon else 0
		var weapon_cooldown = weapon.cooldown if "cooldown" in weapon else 0

		print("[DEBUG] %s (LV %d) - DMG: %.1f, CD: %.2fs" % [weapon_name, weapon_level, weapon_damage, weapon_cooldown])

		# Extra info for orbital weapons
		if weapon.has_method("get_class") and weapon.get_class() == "OrbitalWeapon":
			if "num_orbitals" in weapon:
				print("  └─ Orbitals: %d, Radius: %.0f, Speed: %.0f°/s" % [
					weapon.num_orbitals,
					weapon.orbit_radius if "orbit_radius" in weapon else 0,
					weapon.rotation_speed if "rotation_speed" in weapon else 0
				])

	print("[DEBUG] ===================\n")

func _toggle_debug_overlay() -> void:
	# We'll implement this later with Stats Overlay
	print("[DEBUG] Debug overlay not implemented yet")

func _toggle_verbose() -> void:
	_verbose = not _verbose
	print("[DEBUG] Verbose Mode: ", "ON" if _verbose else "OFF")

func is_god_mode() -> bool:
	return _god_mode
