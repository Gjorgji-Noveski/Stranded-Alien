extends Control

signal warmth_depleted

export (float) onready var fill_up_value = 1
export (float) onready var fill_up_speed  = 0.2
export (float) onready var decay_value = 1
export (float) onready var decay_speed = 1


func _ready() -> void:
	adjust_settings_for_difficulty()
	$FillUpTimer.wait_time = self.fill_up_speed
	$DecayTimer.wait_time = self.decay_speed
	
func _on_FillUpTimer_timeout() -> void:
	$ProgressBar.value += self.fill_up_value

func _on_DecayTimer_timeout() -> void:
	$ProgressBar.value -= self.decay_value
	if $ProgressBar.value <= 0:
		emit_signal("warmth_depleted")

func stop_timers() -> void:
	$DecayTimer.stop()
	$FillUpTimer.stop()

func adjust_settings_for_difficulty():
	if GlobalVariables.game_difficulty == GlobalVariables.difficulty.easy:
		self.decay_speed /= 1
		self.fill_up_speed /= 1.5
	elif GlobalVariables.game_difficulty == GlobalVariables.difficulty.medium:
		self.decay_speed /= 1.2
	else:
		self.decay_speed /= 1.3
