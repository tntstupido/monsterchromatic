extends Button

# We use the class_name Upgrade, assuming it's registered. If not, we might need to preload.
const UpgradeScript = preload("res://scenes/resources/Upgrade.gd")

var _upgrade: Resource # Tyed as Upgrade

@onready var title_label: Label = %TitleLabel
@onready var desc_label: Label = %DescriptionLabel
@onready var icon_rect: TextureRect = %IconRect

signal selected(upgrade)

func set_upgrade(upgrade: Resource) -> void:
	_upgrade = upgrade
	title_label.text = upgrade.title
	desc_label.text = upgrade.description
	# if upgrade.icon: icon_rect.texture = upgrade.icon

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	selected.emit(_upgrade)
