extends Area2D

@export var xp_value: int = 1
@export var speed: float = 400.0

var _target: Node2D = null

func _ready() -> void:
	add_to_group("gem")
	
func _process(delta: float) -> void:
	if _target:
		global_position = global_position.move_toward(_target.global_position, speed * delta)
		speed += 10.0 * delta # Acceleration
		
		if global_position.distance_to(_target.global_position) < 10.0:
			_collect()

func collect(target: Node2D) -> void:
	_target = target
	# Disable monitoring to prevent double triggers if necessary, 
	# though typically the magnet area detects it, and this handles the movement.
	# We want the pickup to happen when it touches the player? 
	# Or when it gets close enough via move_toward?
	# In common implementation: Magnet Area triggers "collect()" which starts the lerp.
	# When it reaches the player (distance < X), it calls logic.

func _collect() -> void:
	ExperienceManager.add_experience(xp_value)
	queue_free()
