extends StaticBody2D

@onready var _sprite: Sprite2D = get_node_or_null("Sprite2D")

@export var wobble_intensity: float = 8.0
@export var wobble_duration: float = 0.5

var _wobble_tween: Tween

func _ready() -> void:
	# Ensure Y-sorting is functional
	y_sort_enabled = true
	if _sprite:
		_sprite.y_sort_enabled = true

func wobble() -> void:
	if not _sprite: return
	
	if _wobble_tween:
		_wobble_tween.kill()
	
	_wobble_tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	_wobble_tween.tween_property(_sprite, "rotation_degrees", wobble_intensity, wobble_duration * 0.2)
	_wobble_tween.tween_property(_sprite, "rotation_degrees", -wobble_intensity * 0.8, wobble_duration * 0.2)
	_wobble_tween.tween_property(_sprite, "rotation_degrees", 0.0, wobble_duration * 0.6)

func take_damage(_amount: float) -> void:
	# Environment objects just wobble when "hit"
	wobble()
