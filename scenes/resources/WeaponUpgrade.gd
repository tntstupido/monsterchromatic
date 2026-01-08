extends Upgrade
class_name WeaponUpgrade

@export var weapon_name: String
@export var weapon_scene: PackedScene

func apply_upgrade(player: Node) -> void:
	if not player.has_method("add_weapon"):
		return
		
	var existing_weapon = player.get_weapon_by_name(weapon_name)
	if existing_weapon:
		if existing_weapon.has_method("level_up"):
			existing_weapon.level_up()
	else:
		player.add_weapon(weapon_scene)
