extends "res://scenes/projectile/Projectile.gd"

@export var max_distance: float = 150.0
@export var return_speed: float = 400.0
@export var rotation_speed: float = 15.0

enum State {FLYING_OUT, RETURNING}
var _state: int = State.FLYING_OUT
var _start_pos: Vector2
var _target: Node2D

signal caught

func _ready() -> void:
	super._ready()
	_start_pos = global_position

func reset(pos: Vector2, dir: Vector2, spd: float, dmg: float) -> void:
	super.reset(pos, dir, spd, dmg)
	_state = State.FLYING_OUT
	_start_pos = pos
	# Find player to return to
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		_target = players[0]

func _process(delta: float) -> void:
	# Spin visual
	rotation += rotation_speed * delta
	
	match _state:
		State.FLYING_OUT:
			position += direction * speed * delta
			if global_position.distance_to(_start_pos) >= max_distance:
				_state = State.RETURNING
				
		State.RETURNING:
			if is_instance_valid(_target):
				var dir_to_target = (_target.global_position - global_position).normalized()
				position += dir_to_target * return_speed * delta
				
				if global_position.distance_to(_target.global_position) < 20.0:
					_return_to_pool()
			else:
				# Target lost, just disappear
				_return_to_pool()
	
	# Override life_time check from base class if needed, 
	# but base class _process also runs. 
	# We need to be careful not to double move or have base class kill it too early.
	# Actually, base class _process moves it too!
	# We should probably NOT call super._process(delta) if we want custom movement.
	# But we can't easily prevent base _process from running if we extend it.
	# Strategy: Set base speed to 0 in RETURNING state? 
	# Or better: Override _process completely and DO NOT call super._process(delta).
	
	# Re-implementing base logic minus movement:
	life_time -= delta
	if life_time <= 0.0:
		_return_to_pool()

func _return_to_pool() -> void:
	emit_signal("caught")
	if pool:
		pool.return_instance(self)
	else:
		queue_free()
