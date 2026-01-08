extends CanvasLayer

@onready var health_bar: ProgressBar = %HealthBar
@onready var timer_label: Label = %TimerLabel
@onready var wave_label: Label = %WaveLabel

@onready var xp_bar: ProgressBar = %XPBar
@onready var level_label: Label = %LevelLabel

func _ready() -> void:
	if ExperienceManager:
		ExperienceManager.experience_gained.connect(update_xp)
		ExperienceManager.level_up.connect(update_level)
		# Initialize
		update_xp(ExperienceManager.current_experience, ExperienceManager.target_experience)
		update_level(ExperienceManager.current_level)

func update_xp(current: int, target: int) -> void:
	xp_bar.max_value = target
	xp_bar.value = current

func update_level(new_level: int) -> void:
	level_label.text = "Regret %d" % new_level

func update_health(current: float, maximum: float) -> void:
	health_bar.max_value = maximum
	health_bar.value = current
	health_bar.get_node("%HealthText").text = "HP: %d / %d" % [int(current), int(maximum)]


func update_wave(value: int) -> void:
	wave_label.text = "Suffering Cycle %d" % value


func update_time(seconds: float) -> void:
	var total_seconds: int = int(seconds)
	var minutes: int = int(total_seconds / 60.0)
	var secs: int = total_seconds % 60
	timer_label.text = "%02d:%02d" % [minutes, secs]
