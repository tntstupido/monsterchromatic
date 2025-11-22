extends CharacterBody2D

signal health_changed(current, maximum)
signal died

@export var move_speed: float = 260.0
@export var acceleration: float = 1400.0
@export var friction: float = 1800.0
@export var max_health: float = 100.0

# Weapon System
@export var starting_weapon_scene: PackedScene = preload("res://scenes/weapon/Hammer.tscn")
const WeaponScript = preload("res://scenes/weapon/Weapon.gd")
var current_weapon: Node # Typed as Node or WeaponScript if possible, but Node is safe with casting

@export var bounce_speed: float = 12.0
@export var bounce_amount: float = 0.12

var main: Node
var _health: float
var _rng := RandomNumberGenerator.new()
var _aim_direction := Vector2.RIGHT
var _bounce_phase: float = 0.0
var _facing_sign: float = 1.0

@onready var _input_manager: Node = get_node_or_null("/root/InputManager")
@onready var _muzzle: Marker2D = %Muzzle
@onready var _visual: Node2D = get_node_or_null("%Visual")
@onready var _sprite: Sprite2D = get_node_or_null("%Visual/Sprite2D")


func _ready() -> void:
	add_to_group("player")
	_rng.randomize()
	_health = max_health
	emit_signal("health_changed", _health, max_health)
	
	if starting_weapon_scene:
		equip_weapon(starting_weapon_scene)


func _physics_process(delta: float) -> void:
	var input_dir := _get_move_vector()

	if input_dir != Vector2.ZERO:
		velocity = velocity.move_toward(input_dir * move_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	_update_facing(input_dir)
	_update_bounce(input_dir, delta)
	move_and_slide()


func _process(_delta: float) -> void:
	_aim_direction = _get_aim_direction()

	if _aim_direction != Vector2.ZERO and current_weapon:
		current_weapon.attack(_aim_direction)


func equip_weapon(weapon_scene: PackedScene) -> void:
	if current_weapon:
		current_weapon.queue_free()
		
	var new_weapon = weapon_scene.instantiate()
	if new_weapon is WeaponScript:
		current_weapon = new_weapon
		if _muzzle:
			_muzzle.add_child(current_weapon)
		else:
			add_child(current_weapon)
	else:
		push_error("Equipped scene is not a Weapon")
		new_weapon.queue_free()


func _get_aim_direction() -> Vector2:
	var aim: Vector2 = _input_manager.get_aim_vector() if _input_manager and _input_manager.has_method("get_aim_vector") else Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	if aim == Vector2.ZERO and main and main.has_method("get_closest_enemy_direction"):
		aim = main.get_closest_enemy_direction(global_position)
	return aim.normalized() if aim != Vector2.ZERO else Vector2.ZERO


func _get_move_vector() -> Vector2:
	if _input_manager and _input_manager.has_method("get_move_vector"):
		return _input_manager.get_move_vector()
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")


func take_damage(amount: float) -> void:
	_health -= amount
	emit_signal("health_changed", _health, max_health)
	if _health <= 0.0:
		died.emit()


func heal(amount: float) -> void:
	_health = clamp(_health + amount, 0.0, max_health)
	emit_signal("health_changed", _health, max_health)


func _update_facing(input_dir: Vector2) -> void:
	if _visual == null:
		return
	if input_dir.x > 0.0:
		_facing_sign = -1.0 # default sprite faces left; flip to face right
	elif input_dir.x < 0.0:
		_facing_sign = 1.0


func _update_bounce(input_dir: Vector2, delta: float) -> void:
	if _visual == null:
		return

	if input_dir == Vector2.ZERO:
		_bounce_phase = 0.0
		_visual.position.y = 0.0
		_visual.scale = Vector2(_facing_sign, 1.0)
		return

	_bounce_phase += delta * bounce_speed
	var wave := sin(_bounce_phase)
	var squash := wave * bounce_amount
	# Stretch in Y, squash in X for cartoony feel.
	var scale_x := _facing_sign * (1.0 - (squash * 0.5))
	var scale_y := 1.0 + squash
	_visual.scale = Vector2(scale_x, scale_y)
	# _visual.position.y = wave * 3.0 # Removed to keep feet planted
