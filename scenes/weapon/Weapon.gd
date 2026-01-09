class_name Weapon
extends Node2D

@export var damage: float = 10.0
@export var cooldown: float = 0.5
@export var weapon_name: String = "Weapon"

@export_group("Sound Effects")
@export var attack_sound: AudioStream
@export var hit_sound: AudioStream
@export var level_up_sound: AudioStream

var level: int = 1
var _cooldown_timer: float = 0.0
var _can_attack: bool = true

func level_up() -> void:
	level += 1
	damage *= 1.1
	cooldown *= 0.9

	# Play level up sound
	if level_up_sound:
		AudioManager.play_ui_sound(level_up_sound)

	# Emit signal through player
	var player = get_tree().get_first_node_in_group("player")
	if player and player.has_signal("weapon_leveled_up"):
		player.weapon_leveled_up.emit(self)

	print(weapon_name, " leveled up to ", level, "! Damage: ", damage, ", Cooldown: ", cooldown)

func _process(delta: float) -> void:
	if not _can_attack:
		_cooldown_timer -= delta
		if _cooldown_timer <= 0.0:
			_can_attack = true


func attack(direction: Vector2) -> void:
	if not _can_attack:
		return

	# Play attack sound
	if attack_sound:
		AudioManager.play_sound(attack_sound, global_position)

	_perform_attack(direction)
	_can_attack = false
	_cooldown_timer = cooldown


func _perform_attack(_direction: Vector2) -> void:
	# Override in subclasses
	pass


func _play_hit_sound() -> void:
	# Called by subclasses when they hit something
	if hit_sound:
		AudioManager.play_sound(hit_sound, global_position)
