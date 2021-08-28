extends Node2D

func _ready() -> void:
	get_tree().current_scene = self
	$Player.coin_counter.connect("acquired_coin",self,"check_coins_for_win")
	GlobalVariables.player.connect('player_death', self, 'restart_on_input')

func check_coins_for_win() -> void:
	if $Player.coin_counter.coins_gathered == $Player.coin_counter.total_coins:
		var player_ui_text = load("res://src/Actors/Level text.tscn").instance()
		player_ui_text.show_victory()
		$Player/CanvasLayer.call_deferred('add_child', player_ui_text)
		$Player.set_physics_process(false)
		$Player.animation_player.stop()
		$Player.frozen_bar.stop_timers()
		$"Barrel spawner".current_barrel.get_node("Timer").stop()


func restart_on_input() -> void:
	var level_text = load("res://src/Actors/Level text.tscn").instance()
	level_text.show_froze_text()
	GlobalVariables.player.get_node("CanvasLayer").call_deferred('add_child',level_text)
	
