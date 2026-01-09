extends Node

signal experience_gained(current: int, target: int)
signal level_up(new_level: int)

var current_experience: int = 0
var current_level: int = 1
var target_experience: int = 5

const XP_GROWTH_FACTOR: float = 1.2
const BASE_XP_TARGET: int = 5

@export var level_up_sound: AudioStream

func _ready() -> void:
	# Initialize target experience for level 1
	_update_target_experience()
	# Emit initial state for UI updates
	call_deferred("emit_signal", "experience_gained", current_experience, target_experience)
	call_deferred("emit_signal", "level_up", current_level)

func add_experience(amount: int) -> void:
	current_experience += amount
	emit_signal("experience_gained", current_experience, target_experience)
	
	while current_experience >= target_experience:
		current_experience -= target_experience
		current_level += 1
		_update_target_experience()

		# Play level up sound
		if level_up_sound:
			AudioManager.play_ui_sound(level_up_sound)

		emit_signal("level_up", current_level)
		emit_signal("experience_gained", current_experience, target_experience)
		print("Leveled up to: ", current_level)

func _update_target_experience() -> void:
	target_experience = int(BASE_XP_TARGET * pow(XP_GROWTH_FACTOR, current_level - 1))
