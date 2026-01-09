extends Area2D

@export var slow_factor: float = 0.5
@export var duration: float = 5.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	# Self destruct after duration
	await get_tree().create_timer(duration).timeout
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if "speed_multiplier" in body:
			body.speed_multiplier = slow_factor

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		if "speed_multiplier" in body:
			body.speed_multiplier = 1.0
