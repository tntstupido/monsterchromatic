extends CanvasLayer

const UpgradeCardScene = preload("res://scenes/ui/UpgradeCard.tscn")

@export var upgrade_count: int = 4
@onready var card_container: GridContainer = %CardContainer
@onready var speech_bubble: Node2D = %SpeechBubble
@onready var ghost: Control = %Ghost

# Shopkeeper interaction cooldown
var _last_click_time: float = 0.0
const CLICK_COOLDOWN: float = 0.5  # seconds

var sarcastic_quotes: Array[String] = [
	"Pick your poison.",
	"It won't help anyway.",
	"Delaying the funeral?",
	"Oh look, you're still alive.",
	"Spending your last moments shopping?",
	"None of these will save you.",
	"How are you not dead yet?",
	"Another desperate purchase?",
	"Death is patient. I'm not.",
	"Your coin, my condolences.",
	"This won't end well for you.",
	"Still wasting time, I see.",
	"Prolonging the agony, are we?",
	"I'll be here after you're gone.",
	"Choose quickly. Time's running out.",
	"My prices are criminal. So is your luck."
]

func _ready() -> void:
	# Pause the game
	get_tree().paused = true
	
	# Clear existing children if any
	for child in card_container.get_children():
		child.queue_free()
		
	# Get upgrades
	var upgrades = UpgradeManager.get_random_upgrades(upgrade_count)
	
	# Instantiate cards
	for upgrade in upgrades:
		var card = UpgradeCardScene.instantiate()
		card_container.add_child(card)
		card.set_upgrade(upgrade)
		card.selected.connect(_on_card_selected)
		
	_setup_shopkeeper()

func _setup_shopkeeper() -> void:
	# Start speech (don't auto-hide - stays visible for shopkeeper)
	speech_bubble.display_text(sarcastic_quotes.pick_random(), 2.5, false)

	# Set pivot for scale animation
	ghost.pivot_offset = ghost.size / 2

	# Make shopkeeper clickable
	if ghost is TextureRect:
		ghost.mouse_filter = Control.MOUSE_FILTER_STOP
		ghost.gui_input.connect(_on_shopkeeper_clicked)

	# Wobble animation
	var tween = create_tween().set_loops()
	tween.tween_property(ghost, "scale", Vector2(1.05, 0.95), 1.0).set_trans(Tween.TRANS_SINE)
	tween.tween_property(ghost, "scale", Vector2(0.95, 1.05), 1.0).set_trans(Tween.TRANS_SINE)

func _on_shopkeeper_clicked(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Cooldown check
		var current_time = Time.get_ticks_msec() / 1000.0
		if current_time - _last_click_time < CLICK_COOLDOWN:
			return  # Ignore rapid clicks
		_last_click_time = current_time

		# Check if speech bubble still exists
		if not is_instance_valid(speech_bubble):
			return

		# Display new random quote (don't auto-hide)
		speech_bubble.display_text(sarcastic_quotes.pick_random(), 2.5, false)

		# Check if ghost still exists
		if not is_instance_valid(ghost):
			return

		# Random reaction animation (3 variations)
		_play_random_reaction()

func _play_random_reaction() -> void:
	var animation_type = randi() % 3
	var react_tween = create_tween()

	match animation_type:
		0:  # Wiggle (left-right shake)
			react_tween.tween_property(ghost, "rotation_degrees", -5, 0.1)
			react_tween.tween_property(ghost, "rotation_degrees", 5, 0.1)
			react_tween.tween_property(ghost, "rotation_degrees", 0, 0.1)

		1:  # Bounce (scale up and down)
			react_tween.tween_property(ghost, "scale", Vector2(1.15, 0.85), 0.1).set_trans(Tween.TRANS_BACK)
			react_tween.tween_property(ghost, "scale", Vector2(0.95, 1.05), 0.1).set_trans(Tween.TRANS_BACK)
			react_tween.tween_property(ghost, "scale", Vector2(1.0, 1.0), 0.1).set_trans(Tween.TRANS_SINE)

		2:  # Shrug (rotate + slight move up)
			var original_pos = ghost.position
			react_tween.parallel().tween_property(ghost, "rotation_degrees", 15, 0.15)
			react_tween.parallel().tween_property(ghost, "position:y", original_pos.y - 10, 0.15)
			react_tween.parallel().tween_property(ghost, "rotation_degrees", 0, 0.15).set_delay(0.15)
			react_tween.parallel().tween_property(ghost, "position:y", original_pos.y, 0.15).set_delay(0.15)

func _on_card_selected(upgrade: Resource) -> void:
	UpgradeManager.apply_upgrade(upgrade)
	_close()

func _close() -> void:
	get_tree().paused = false
	queue_free()
