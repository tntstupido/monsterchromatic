extends Node
const WeaponUpgradeClass = preload("res://scenes/resources/WeaponUpgrade.gd")

var _upgrade_pool: Array[Upgrade] = []

func _ready() -> void:
	_init_pool()

func _init_pool() -> void:
	# 1. Stats Upgrades
	var u1 = Upgrade.new()
	u1.id = "heal"
	u1.title = "Denial of Death"
	u1.description = "Restore Health (Ignore the inevitable)"
	
	var u2 = Upgrade.new()
	u2.id = "speed"
	u2.title = "Panic Sprints"
	u2.description = "Speed Up (Run from your problems)"
	
	_upgrade_pool.append(u1)
	_upgrade_pool.append(u2)

	# 2. Weapon Upgrades
	var axe = WeaponUpgradeClass.new()
	axe.id = "weapon_axe"
	axe.weapon_name = "Axe"
	axe.weapon_scene = preload("res://scenes/weapon/Axe.tscn")
	axe.title = "Cold Iron Axe"
	axe.description = "Acquire or upgrade the Boomerang Axe."

	var hammer = WeaponUpgradeClass.new()
	hammer.id = "weapon_hammer"
	hammer.weapon_name = "Hammer"
	hammer.weapon_scene = preload("res://scenes/weapon/Hammer.tscn")
	hammer.title = "Giant Mallet"
	hammer.description = "Acquire or upgrade the Circle Hammer."
	
	_upgrade_pool.append(axe)
	_upgrade_pool.append(hammer)

func get_random_upgrades(amount: int) -> Array[Upgrade]:
	var options: Array[Upgrade] = []
	if _upgrade_pool.is_empty():
		return options
		
	var available = _upgrade_pool.duplicate()
	available.shuffle()
	
	for i in range(min(amount, available.size())):
		options.append(available[i])
		
	return options

func apply_upgrade(upgrade: Upgrade) -> void:
	var player = get_tree().get_first_node_in_group("player")
	if not player:
		return
		
	# Polymorphic call
	upgrade.apply_upgrade(player)
	
	# Fallback for old/simple upgrades if needed
	match upgrade.id:
		"heal":
			player.heal(100.0)
		"speed":
			player.speed_multiplier *= 1.1
