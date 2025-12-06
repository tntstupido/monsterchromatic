extends CanvasLayer

const UpgradeCardScene = preload("res://scenes/ui/UpgradeCard.tscn")

@onready var card_container: HBoxContainer = %CardContainer

func _ready() -> void:
	# Pause the game
	get_tree().paused = true
	
	# Clear existing children if any
	for child in card_container.get_children():
		child.queue_free()
		
	# Get upgrades
	var upgrades = UpgradeManager.get_random_upgrades(3)
	
	# Instantiate cards
	for upgrade in upgrades:
		var card = UpgradeCardScene.instantiate()
		card_container.add_child(card)
		card.set_upgrade(upgrade)
		card.selected.connect(_on_card_selected)

func _on_card_selected(upgrade: Resource) -> void:
	UpgradeManager.apply_upgrade(upgrade)
	_close()

func _close() -> void:
	get_tree().paused = false
	queue_free()
