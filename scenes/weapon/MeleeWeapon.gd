extends Weapon

@export var swing_duration: float = 0.2
@export var swing_angle: float = 90.0

@onready var _hitbox: Area2D = $Hitbox
@export var near_miss_radius: float = 160.0

var _anim_player: AnimationPlayer
var _hit_this_swing: Array[Node] = []

func _ready() -> void:
	_anim_player = get_node_or_null("AnimationPlayer")
	
	if _hitbox:
		_hitbox.monitoring = false
		_hitbox.body_entered.connect(_on_body_entered)

func _perform_attack(direction: Vector2) -> void:
	_hit_this_swing.clear()
	rotation = direction.angle()
	if _anim_player:
		_anim_player.play("swing")
		# Wait for animation or use callback
	elif _hitbox:
		# Simple manual swing if no animation player
		_hitbox.monitoring = true
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", rotation_degrees + swing_angle, swing_duration)
		tween.tween_callback(_on_attack_finished)

func _on_attack_finished() -> void:
	if _hitbox:
		_hitbox.monitoring = false
	_check_near_misses()

func _check_near_misses() -> void:
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		if enemy in _hit_this_swing: continue
		var dist = global_position.distance_to(enemy.global_position)
		if dist < near_miss_radius:
			if enemy.has_method("say") and randf() < 0.5:
				var miss_comments = ["Too slow!", "Missed me!", "Dummy!", "Try harder!", "Nice swing, loser!"]
				enemy.say(miss_comments.pick_random(), 1.5)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemy") and body.has_method("take_damage"):
		if not body in _hit_this_swing:
			_hit_this_swing.append(body)
			body.take_damage(damage)
			# Play hit sound using parent class method
			_play_hit_sound()
	elif body.is_in_group("environment") and body.has_method("wobble"):
		body.wobble()
