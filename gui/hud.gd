extends CanvasLayer

@onready var health_bar: ProgressBar = $HealthBar

func _on_player_health_changed(newValue: int) -> void:
	health_bar.value = newValue
