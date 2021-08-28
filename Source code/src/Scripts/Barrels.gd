extends StaticBody2D

signal spawn_new_barrel
signal warm_up(finished)
onready var animation_player = $AnimationPlayer

func _ready() -> void:
	self.animation_player.play("Fire")
#When you want to disconnect a signal, you call the disconnect method from
#the node that emits the signal, not from kojgode node
func _on_Safe_zone_area_entered(_area: Area2D) -> void:
	if not $Timer.paused:
		$Timer.start()
	else:
		$Timer.paused = false
	GlobalVariables.player.warm_up(false)


func _on_Timer_timeout() -> void:
	emit_signal("spawn_new_barrel")
	emit_signal("warm_up", true)

func turn_off_fire()->void:
	$"Fire sprite sheet".visible = false
	animation_player.stop()

func stop_timers()->void:
	$Timer.stop()


func _on_Safe_zone_area_exited(area: Area2D) -> void:
	GlobalVariables.player.warm_up(true)
	$Timer.paused = true
