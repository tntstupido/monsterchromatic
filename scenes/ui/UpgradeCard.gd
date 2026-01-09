extends Button

# We use the class_name Upgrade, assuming it's registered. If not, we might need to preload.
const UpgradeScript = preload("res://scenes/resources/Upgrade.gd")

var _upgrade: Resource # Tyed as Upgrade

@onready var title_label: Label = %TitleLabel
@onready var desc_label: Label = %DescriptionLabel
@onready var icon_rect: TextureRect = %IconRect
@onready var background_rect: TextureRect = %Background
@onready var vbox: VBoxContainer = $VBoxContainer

# Array of card background textures (paper + metal) for random selection
const CARD_TEXTURES = [
	"res://assets/ui/shop/source/paper1.png",
	"res://assets/ui/shop/source/paper2.png",
	"res://assets/ui/shop/source/paper3.png",
	"res://assets/ui/shop/source/paper4.png",
	"res://assets/ui/shop/source/paper5.png",
	"res://assets/ui/shop/source/paper6.png",
	"res://assets/ui/shop/source/metal1.png",
	"res://assets/ui/shop/source/metal2.png",
]

var _jagged_points: PackedVector2Array = PackedVector2Array()

signal selected(upgrade)

func set_upgrade(upgrade: Resource) -> void:
	_upgrade = upgrade
	title_label.text = upgrade.title
	desc_label.text = upgrade.description

	# Load icon based on upgrade ID
	var icon_path: String = ""
	match upgrade.id:
		"heal":
			icon_path = "res://assets/ui/icons/health_icon.png"
		"speed":
			icon_path = "res://assets/ui/icons/speed_icon.png"
		"weapon_axe":
			icon_path = "res://assets/ui/icons/axe_icon.png"
		"weapon_hammer":
			icon_path = "res://assets/ui/icons/hammer_icon.png"
		"weapon_blessed_cross":
			icon_path = "res://assets/ui/icons/blessed_cross_icon.png"
		"weapon_cursed_skull":
			icon_path = "res://assets/ui/icons/cursed_skull_icon.png"
		"weapon_prayer_beads":
			icon_path = "res://assets/ui/icons/prayer_beads_icon.png"

	if icon_path != "" and ResourceLoader.exists(icon_path):
		icon_rect.texture = load(icon_path)
		icon_rect.visible = true
	else:
		icon_rect.visible = false

func _ready() -> void:
	pressed.connect(_on_pressed)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pivot_offset = custom_minimum_size / 2

	# Randomize card texture for variety (paper or metal)
	var random_texture = CARD_TEXTURES[randi() % CARD_TEXTURES.size()]
	background_rect.texture = load(random_texture)

func _generate_jagged_points() -> void:
	var card_size = custom_minimum_size
	_jagged_points.clear()
	
	# Generate points with subtle noise
	var segments = 6 # Reduced for simpler polygon
	var noise_amt = 0.8 # Reduced noise
	
	# Top edge
	for i in range(segments):
		var x = card_size.x * (float(i) / float(segments - 1))
		_jagged_points.append(Vector2(x, randf_range(-noise_amt, noise_amt)))
	
	# Right edge
	for i in range(segments):
		var y = card_size.y * (float(i) / float(segments - 1))
		_jagged_points.append(Vector2(card_size.x + randf_range(-noise_amt, noise_amt), y))
	
	# Bottom edge (reverse)
	for i in range(segments):
		var x = card_size.x * (1.0 - float(i) / float(segments - 1))
		_jagged_points.append(Vector2(x, card_size.y + randf_range(-noise_amt, noise_amt)))
	
	# Left edge (reverse)
	for i in range(segments):
		var y = card_size.y * (1.0 - float(i) / float(segments - 1))
		_jagged_points.append(Vector2(randf_range(-noise_amt, noise_amt), y))

# Disabled for now due to triangulation errors
# func _draw() -> void:
# 	if _jagged_points.size() == 0:
# 		return
# 	
# 	# Draw filled polygon (background)
# 	draw_colored_polygon(_jagged_points, Color("a69980"))
# 	
# 	# Draw border
# 	var border_points = _jagged_points.duplicate()
# 	border_points.append(_jagged_points[0]) # Close the loop
# 	draw_polyline(border_points, Color.BLACK, 3.0, true)

func _on_mouse_entered() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(1.05, 1.05), 0.1)
	tween.parallel().tween_property(self, "rotation_degrees", randf_range(-2, 2), 0.1)

func _on_mouse_exited() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)
	tween.parallel().tween_property(self, "rotation_degrees", 0, 0.1)

func _on_pressed() -> void:
	selected.emit(_upgrade)
