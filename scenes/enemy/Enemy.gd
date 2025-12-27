extends CharacterBody2D

signal died(enemy)

@export var move_speed: float = 140.0
@export var acceleration: float = 600.0
@export var max_health: float = 30.0
@export var contact_damage: float = 10.0
@export var contact_cooldown: float = 0.7

var target: Node2D
var _health: float
var _contact_timer: float = 0.0
var _wobble_phase: float = 0.0
var _facing_sign: float = 1.0

@export var bounce_speed: float = 10.0
@export var bounce_amount: float = 0.1
@export var tilt_amount: float = 0.12

@export var dust_scene: PackedScene = preload("res://scenes/vfx/DustParticles.tscn")
var _last_wave: float = 0.0

var speech_bubble_scene := preload("res://scenes/ui/SpeechBubble/SpeechBubble.tscn")
var _idle_comment_timer: float = 0.0


func _ready() -> void:
	_health = max_health
	add_to_group("enemy")


@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	if target:
		var dir := (target.global_position - global_position).normalized()
		velocity = velocity.move_toward(dir * move_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)

	# Update facing and wobble
	_update_facing()
	_update_wobble(delta)


	_contact_timer = max(0.0, _contact_timer - delta)
	_idle_comment_timer = max(0.0, _idle_comment_timer - delta)
	
	if _idle_comment_timer <= 0.0 and velocity.length() > 10.0:
		_idle_comment_timer = randf_range(5.0, 15.0)
		if randf() < 0.3:
			var idle_comments = ["Come here!", "Stop running!", "I see you...", "Dinnertime!", "Looking tasty.", "Don't trip!"]
			say(idle_comments.pick_random(), 1.5)

	var collision := move_and_collide(velocity * delta)

	if collision and collision.get_collider() and collision.get_collider().is_in_group("player"):
		_hit_player(collision.get_collider())


func take_damage(amount: float) -> void:
	_health -= amount
	
	var responses = ["Ouch!", "Is that all?", "Nice try!", "Watch it!", "You're bad at this.", "Meh."]
	if randf() < 0.4:
		say(responses.pick_random(), 1.5)
		
	if _health <= 0.0:
		_die()


func say(text: String, duration: float = 1.5) -> void:
	if not speech_bubble_scene: return
	var bubble = speech_bubble_scene.instantiate()
	# Add to parent so it persists even if enemy dies
	get_parent().add_child(bubble)
	bubble.global_position = global_position
	bubble.display_text(text, duration)


func _hit_player(player: Node) -> void:
	if _contact_timer > 0.0:
		return
	_contact_timer = contact_cooldown
	if player.has_method("take_damage"):
		player.take_damage(contact_damage)


func _die() -> void:
	var gem_scene = preload("res://scenes/objects/Gem.tscn")
	var gem = gem_scene.instantiate()
	gem.global_position = global_position
	get_parent().call_deferred("add_child", gem)
	
	died.emit(self)
	queue_free()


func _update_facing() -> void:
	if velocity.x > 0.1:
		_facing_sign = -1.0 # Asset faces LEFT, so -1 flips to RIGHT
	elif velocity.x < -0.1:
		_facing_sign = 1.0


func _update_wobble(delta: float) -> void:
	if not sprite:
		return

	if velocity.length() < 0.1:
		_wobble_phase = 0.0
		sprite.position.y = lerp(sprite.position.y, 0.0, 10.0 * delta)
		sprite.scale = sprite.scale.lerp(Vector2(_facing_sign, 1.0), 10.0 * delta)
		sprite.rotation = lerp(sprite.rotation, 0.0, 10.0 * delta)
		return

	_wobble_phase += delta * bounce_speed
	var wave := sin(_wobble_phase)
	var squash := wave * bounce_amount
	
	# Squash & Stretch
	sprite.scale = Vector2(_facing_sign * (1.0 - (squash * 0.5)), 1.0 + squash)
	
	# Tilt
	sprite.rotation = wave * tilt_amount
	
	# Vertical bounce
	sprite.position.y = - abs(wave) * 2.0
	
	if sign(wave) != sign(_last_wave) and abs(wave) < 0.2:
		_spawn_dust()
	_last_wave = wave

func _spawn_dust() -> void:
	if not dust_scene: return
	var dust = dust_scene.instantiate()
	get_parent().add_child(dust)
	dust.global_position = global_position + Vector2(0, 10)
