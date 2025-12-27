extends Node

# Global AudioManager for slapstick sound effects
# Supports pitch randomization for variety

func play_sound(stream: AudioStream, position: Vector2 = Vector2.ZERO, volume: float = 0.0, pitch_min: float = 0.9, pitch_max: float = 1.1) -> void:
	if not stream: return
	
	var player = AudioStreamPlayer2D.new()
	add_child(player)
	
	player.stream = stream
	player.global_position = position
	player.volume_db = volume
	player.pitch_scale = randf_range(pitch_min, pitch_max)
	
	player.finished.connect(player.queue_free)
	player.play()

func play_ui_sound(stream: AudioStream, volume: float = 0.0, pitch: float = 1.0) -> void:
	if not stream: return
	
	var player = AudioStreamPlayer.new()
	add_child(player)
	
	player.stream = stream
	player.volume_db = volume
	player.pitch_scale = pitch
	
	player.finished.connect(player.queue_free)
	player.play()
