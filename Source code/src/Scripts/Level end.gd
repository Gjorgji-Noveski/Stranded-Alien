extends Node2D

onready var in_safe_zone:bool = false
onready var safe_place_text = null 
func _ready() -> void:
	$AnimationPlayer.play("FireAnimation")
	

func _input(event: InputEvent) -> void:
	if self.in_safe_zone:
		if event.is_action_pressed("restart"):
			get_tree().reload_current_scene()
	
func _on_Area2D_area_entered(area: Area2D) -> void:
	self.in_safe_zone = true
	self.safe_place_text = load("res://src/Actors/Level text.tscn").instance()
	GlobalVariables.player.get_node("CanvasLayer").call_deferred('add_child',safe_place_text)
	GlobalVariables.player.warm_up(false)
	


func _on_Area2D_area_exited(area: Area2D) -> void:
	self.in_safe_zone = false
	self.safe_place_text.queue_free()
	GlobalVariables.player.warm_up(true)
