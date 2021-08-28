extends Node

var player setget set_player,get_player
var coins_gathered = 0 setget set_coins_gathered,get_coins_gathered
enum difficulty {easy = 1, medium = 2, hard = 3}
var game_difficulty = null

func set_player(player_ref: Node) -> void:
	player = player_ref
	
func get_player() -> Node:
	return player
	
func set_coins_gathered(n_coins: int) -> void:
	coins_gathered = n_coins
	
func get_coins_gathered() -> int:
	if player == null:
		return 0
	else:
		return coins_gathered
		
