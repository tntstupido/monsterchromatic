extends CanvasLayer

@onready var health_bar: ProgressBar = %HealthBar
@onready var timer_label: Label = %TimerLabel
@onready var wave_label: Label = %WaveLabel

func _ready() -> void:
	pass


func update_health(current: float, maximum: float) -> void:
	health_bar.max_value = maximum
	health_bar.value = current
	health_bar.get_node("%HealthText").text = "HP: %d / %d" % [int(current), int(maximum)]


func update_wave(value: int) -> void:
	wave_label.text = "Wave %d" % value


func update_time(seconds: float) -> void:
	var total_seconds: int = int(seconds)
	var minutes: int = int(total_seconds / 60)
	var secs: int = total_seconds % 60
	timer_label.text = "%02d:%02d" % [minutes, secs]
