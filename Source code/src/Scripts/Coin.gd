extends Node2D

func _ready() -> void:
	pass

func _on_coin_area_area_entered(_area: Area2D) -> void:
	$AudioStreamPlayer.play()
	GlobalVariables.player.increment_coin_count()
	

func _on_AudioStreamPlayer_finished() -> void:
	queue_free()
