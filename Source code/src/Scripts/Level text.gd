extends Control

var safe_place_text setget set_safe_place_text, get_safe_place_text
var victory_text setget set_victory_text, get_victory_text

func get_safe_place_text() -> String:
	return $"Safe place".text

func set_safe_place_text(new_val: String) -> void:
	$"Safe place".text = str(new_val)
	
func get_victory_text() -> String:
	return $"Safe place".text
	
func set_victory_text(new_val: String) -> void:
	$Victory.text = str(new_val)
	
func show_safe_place() ->void:
	$"Safe place".visible = true
	$Victory.visible = false

func show_victory() ->void:
	$"Safe place".visible = false
	$Victory.visible = true
	
func show_froze_text() -> void:
	$"Safe place".visible = false
	$Victory.visible = false
	$"press r".visible = true
	$"you froze".visible = true
	

func _input(event: InputEvent) -> void:
	if $"press r".visible and event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
		GlobalVariables.coins_gathered = 0

