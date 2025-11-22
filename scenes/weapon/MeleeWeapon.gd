extends "res://scenes/weapon/Weapon.gd"

@export var swing_duration: float = 0.2
@export var swing_angle: float = 90.0

@onready var _hitbox: Area2D = $Hitbox
@onready var _sprite: Sprite2D = $Sprite2D
@onready var _anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if _hitbox:
		_hitbox.monitoring = false
		_hitbox.body_entered.connect(_on_body_entered)

func _perform_attack(direction: Vector2) -> void:
	rotation = direction.angle()
	if _anim_player:
		_anim_player.play("swing")
	elif _hitbox:
		# Simple manual swing if no animation player
		_hitbox.monitoring = true
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", rotation_degrees + swing_angle, swing_duration)
		tween.tween_callback(func(): _hitbox.monitoring = false)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemy") and body.has_method("take_damage"):
		body.take_damage(damage)
