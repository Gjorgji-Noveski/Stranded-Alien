extends Node2D

#the max and min distance coins will spawn 
export(int) var max_x_y_pos = 300
export(int) var min_x_y_pos = 100
export(int) var spawn_n_coins = 3

onready var random: RandomNumberGenerator = RandomNumberGenerator.new()
onready var coin = load("res://src/Actors/Coin.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	random.randomize()
	GlobalVariables.player.initialize_coins(self.spawn_n_coins)
	adjust_settings_for_difficulty()
	
func spawn_single_gem(current_barrel)->void:
	var percent = randf()
	if (percent > 0.5):
		var coin_instance = self.coin.instance()
		var pos = get_random_pos()
		if (random.randi_range(0,1)):
			pos.x *= -1
		if (random.randi_range(0,1)):
			pos.y *= -1
		coin_instance.position.x = pos.x + current_barrel.position.x
		coin_instance.position.y = pos.y + current_barrel.position.y
		$".".add_child(coin_instance)


func get_random_pos()->Vector2:
	var random_x_pos = random.randi_range(min_x_y_pos, max_x_y_pos)
	var random_y_pos = random.randi_range(min_x_y_pos, max_x_y_pos)
	return Vector2(random_x_pos, random_y_pos)
	
	
func get_n_random_pos(n_collectibles: int)-> Array:
	var positions = []
	for i in range(n_collectibles):
		var random_x_pos = random.randi_range(min_x_y_pos, max_x_y_pos)
		var random_y_pos = random.randi_range(min_x_y_pos, max_x_y_pos)
		positions.append(Vector2(random_x_pos, random_y_pos))
	return positions

func spawn_coins(positions: Array)-> void:
	for vector in positions:
		var coin_instance = self.coin.instance()
		coin_instance.position.x = vector.x
		coin_instance.position.y = vector.y
		$".".add_child(coin_instance)
	GlobalVariables.player.initialize_coins(self.spawn_n_coins)
	
func adjust_settings_for_difficulty():
	if GlobalVariables.game_difficulty == GlobalVariables.difficulty.easy:
		self.min_x_y_pos *= 1
		self.max_x_y_pos *= 1
		
	elif GlobalVariables.game_difficulty == GlobalVariables.difficulty.medium:
		self.min_x_y_pos *= 2
		self.max_x_y_pos *= 2
	else:
		self.min_x_y_pos *= 3
		self.max_x_y_pos *= 3
