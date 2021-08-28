extends MarginContainer
onready var game_scene = load('res://src/Actors/Level.tscn').instance()

onready var easy_btn = $VBoxContainer/HBoxContainer/MarginContainer/easy_btn
onready var medium_btn = $VBoxContainer/HBoxContainer/MarginContainer2/medium_btn
onready var hard_btn = $VBoxContainer/HBoxContainer/MarginContainer3/hard_btn

func _ready() -> void:
	GlobalVariables.game_difficulty = GlobalVariables.difficulty.medium

func _on_TextureButton_pressed() -> void:
	get_tree().current_scene.queue_free()
	get_tree().root.call_deferred('add_child', game_scene)

func _on_easy_btn_pressed() -> void:
	medium_btn.pressed = false
	hard_btn.pressed = false
	easy_btn.pressed = true
	GlobalVariables.game_difficulty = GlobalVariables.difficulty.easy


func _on_medium_btn_pressed() -> void:
	easy_btn.pressed = false
	hard_btn.pressed = false
	medium_btn.pressed = true
	GlobalVariables.game_difficulty = GlobalVariables.difficulty.medium


func _on_hard_btn_pressed() -> void:
	medium_btn.pressed = false
	easy_btn.pressed = false
	hard_btn.pressed = true
	GlobalVariables.game_difficulty = GlobalVariables.difficulty.hard
