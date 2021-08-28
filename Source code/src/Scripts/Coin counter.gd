extends Control

signal acquired_coin

var coins_gathered:int setget set_coins_gathered,get_coins_gathered
var total_coins:int setget set_total_coins,get_total_coins
var separator: String = "/"

func _ready() -> void:
	set_coins_gathered(GlobalVariables.coins_gathered)
	

func increment_coin_count()->void:
	var new_coin_count: int = int($"coins gathered".text) + 1
	$"coins gathered".text = str(new_coin_count) + self.separator
	emit_signal("acquired_coin")
	GlobalVariables.coins_gathered = new_coin_count

func set_coins_gathered(new_val: int)-> void:
	$"coins gathered".text = str(new_val) + self.separator

func get_coins_gathered()-> int:
	return int($"coins gathered".text)

func set_total_coins(new_val: int)-> void:
	$"total coins".text = str(new_val)

func get_total_coins()-> int:
	return int($"total coins".text)

func _on_Coin_counter_tree_exiting() -> void:
	GlobalVariables.coins_gathered = GlobalVariables.coins_gathered
