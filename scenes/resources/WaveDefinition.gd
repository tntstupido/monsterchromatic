extends Resource
class_name WaveDefinition

@export var start_time: int = 0
@export var end_time: int = 60
@export var spawn_interval: float = 1.0
@export var enemies: Array[PackedScene] = []
@export var boss_scene: PackedScene # Optional: Spawn boss at the END of this wave? Or start?
# Usually Boss is a separate event, but let's keep it simple: Spawns at start of wave if set.

func get_random_enemy() -> PackedScene:
	if enemies.is_empty():
		return null
	return enemies.pick_random()
