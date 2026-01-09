extends VBoxContainer

const WeaponDisplayScene = preload("res://scenes/ui/WeaponDisplay.tscn")

# Map weapon names to their icon paths
const WEAPON_ICONS = {
	"Axe": "res://assets/ui/icons/axe_icon.png",
	"Hammer": "res://assets/ui/icons/hammer_icon.png",
	"Blessed Cross": "res://assets/ui/icons/blessed_cross_icon.png",
	"Cursed Skull": "res://assets/ui/icons/cursed_skull_icon.png",
	"Prayer Beads": "res://assets/ui/icons/prayer_beads_icon.png"
}

var _weapon_displays: Dictionary = {}  # weapon_name -> WeaponDisplay node

func _ready() -> void:
	# Connect to player's weapon signals
	var player = get_tree().get_first_node_in_group("player")
	if player:
		if player.has_signal("weapon_added"):
			player.weapon_added.connect(_on_weapon_added)
		if player.has_signal("weapon_leveled_up"):
			player.weapon_leveled_up.connect(_on_weapon_leveled_up)

		# Add any existing weapons that were added before we were ready
		if "weapons" in player:
			for weapon in player.weapons:
				_on_weapon_added(weapon)

func _on_weapon_added(weapon: Node) -> void:
	if not weapon:
		return

	var weapon_name = weapon.weapon_name if "weapon_name" in weapon else ""
	if weapon_name == "":
		return

	# Check if we already have a display for this weapon
	if weapon_name in _weapon_displays:
		return

	# Create new display
	var display = WeaponDisplayScene.instantiate()
	add_child(display)

	# Get icon texture
	var icon_texture: Texture2D = null
	if weapon_name in WEAPON_ICONS:
		var icon_path = WEAPON_ICONS[weapon_name]
		if ResourceLoader.exists(icon_path):
			icon_texture = load(icon_path)

	# Get initial level
	var level = weapon.level if "level" in weapon else 1

	display.set_weapon_data(icon_texture, level, weapon_name)
	_weapon_displays[weapon_name] = display

func _on_weapon_leveled_up(weapon: Node) -> void:
	if not weapon:
		return

	var weapon_name = weapon.weapon_name if "weapon_name" in weapon else ""
	if weapon_name == "":
		return

	# Update existing display
	if weapon_name in _weapon_displays:
		var display = _weapon_displays[weapon_name]
		var level = weapon.level if "level" in weapon else 1

		# Get icon texture
		var icon_texture: Texture2D = null
		if weapon_name in WEAPON_ICONS:
			var icon_path = WEAPON_ICONS[weapon_name]
			if ResourceLoader.exists(icon_path):
				icon_texture = load(icon_path)

		display.set_weapon_data(icon_texture, level, weapon_name)
