class_name Weapon
extends Node2D

@export var damage: float = 10.0
@export var cooldown: float = 0.5

var _cooldown_timer: float = 0.0
var _can_attack: bool = true

func _process(delta: float) -> void:
	if not _can_attack:
		_cooldown_timer -= delta
		if _cooldown_timer <= 0.0:
			_can_attack = true


func attack(direction: Vector2) -> void:
	if not _can_attack:
		return
		
	_perform_attack(direction)
	_can_attack = false
	_cooldown_timer = cooldown


func _perform_attack(_direction: Vector2) -> void:
	# Override in subclasses
	pass
