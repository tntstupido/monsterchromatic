extends PanelContainer

@onready var icon: TextureRect = %Icon
@onready var level_label: Label = %LevelLabel

var weapon_name: String = ""

func set_weapon_data(icon_texture: Texture2D, level: int, name: String) -> void:
	weapon_name = name

	if icon:
		icon.texture = icon_texture

	if level_label:
		level_label.text = "LV %d" % level
