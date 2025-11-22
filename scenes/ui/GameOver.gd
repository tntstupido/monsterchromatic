extends Control

func _ready() -> void:
	# Ensure the game is unpaused when this scene is loaded, 
	# or if it's an overlay, we might want to keep it paused.
	# But since we are switching scenes, we should unpause.
	# However, if we switch scene, the pause state persists.
	# So we must unpause.
	get_tree().paused = false


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main/Main.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/MainMenu.tscn")
