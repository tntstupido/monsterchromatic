extends "res://scenes/environment/Prop.gd"

# Manual regions for each headstone in the 4x4 tileset (1024x1024 total)
# Each block is 256x256. Adjust these individual Rect2 values for perfect alignment.
var regions: Array[Rect2] = [
	# Row 0
	Rect2(0, 0, 256, 256), Rect2(256, 0, 256, 256), Rect2(512, 0, 256, 256), Rect2(768, 0, 256, 256),
	# Row 1
	Rect2(0, 256, 256, 256), Rect2(256, 256, 256, 256), Rect2(512, 256, 256, 256), Rect2(768, 256, 256, 256),
	# Row 2
	Rect2(0, 512, 256, 256), Rect2(256, 512, 256, 256), Rect2(512, 512, 256, 256), Rect2(768, 512, 256, 256),
	# Row 3
	Rect2(0, 768, 256, 256), Rect2(256, 768, 256, 256), Rect2(512, 768, 256, 256), Rect2(768, 768, 256, 256)
]

func _ready() -> void:
	super._ready()
	# Pick a random region on spawn
	if has_node("Sprite2D"):
		var sprite = $Sprite2D
		sprite.region_enabled = true
		sprite.region_rect = regions.pick_random()
