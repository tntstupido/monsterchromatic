extends Node

var _upgrade_pool: Array[Upgrade] = []

func _ready() -> void:
	_init_pool()

func _init_pool() -> void:
	# Temporary: Create some dummy upgrades for testing
	var u1 = Upgrade.new()
	u1.id = "heal"
	u1.title = "Full Heal"
	u1.description = "Restore 100% Health"
	
	var u2 = Upgrade.new()
	u2.id = "speed"
	u2.title = "Speed Up"
	u2.description = "Increase Movement Speed by 10%"
	
	var u3 = Upgrade.new()
	u3.id = "damage"
	u3.title = "Might"
	u3.description = "Increase Damage by 10%"
	
	_upgrade_pool.append(u1)
	_upgrade_pool.append(u2)
	_upgrade_pool.append(u3)

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
		
	match upgrade.id:
		"heal":
			if player.has_method("heal"):
				# Assuming max health is available or heal handles overflow
				player.heal(1000.0)
		"speed":
			if "move_speed" in player:
				player.move_speed *= 1.1
		"damage":
			# Placeholder: 需要 implementirati globalni damage modifier
			print("Damage increased (TODO)")
	
	upgrade.apply_upgrade(player)
