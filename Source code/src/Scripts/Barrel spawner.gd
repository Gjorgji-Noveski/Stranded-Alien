extends Node2D

onready var parent: Node2D = $".."
onready var barrel_scene = preload("res://src/Actors/Barrels.tscn")
onready var random: RandomNumberGenerator = RandomNumberGenerator.new()
onready var player = $"../Player"
onready var current_barrel = null
onready var level_end = load("res://src/Actors/Level end.tscn")

var total_barrels_spawned: int = 0
var spawned_end: bool = false
onready var spawn_end_on_nth_barrel:int = 3

#so segashna brzina 1000 pikseli gi pominuva za 4 sekundi
# how far away should the spawned barrel be, mnogu e max 4k
onready var min_x_y_pos:int = 800
onready var max_x_y_pos:int = 1600

func adjust_settings_for_difficulty():
	if GlobalVariables.game_difficulty == GlobalVariables.difficulty.easy:
		self.min_x_y_pos *= 1
		self.max_x_y_pos *= 1
		
	elif GlobalVariables.game_difficulty == GlobalVariables.difficulty.medium:
		self.min_x_y_pos *= 1.2
		self.max_x_y_pos *= 1.2
	else:
		self.min_x_y_pos *= 1.4
		self.max_x_y_pos *= 1.4
	
func _ready() -> void:
	random.randomize()
	adjust_settings_for_difficulty()

	if current_barrel == null:
		spawn_barrel()
		current_barrel.connect("spawn_new_barrel",self,"spawn_barrel")
	

func modify_smoke_scale_by_distance() -> void:
	var barrel_pos: Vector2 = Vector2(self.current_barrel.position.x,self.current_barrel.position.y)
	var player_pos: Vector2 = Vector2($"../Player".position.x,$"../Player".position.y)
	var dist_player_barrel: float = calc_dist_barrel_player(barrel_pos,player_pos)

	var smoke_scale: float = scale_number_to_range(self.min_x_y_pos,self.max_x_y_pos, 0,1.5,dist_player_barrel)
	$"../Player/Particles2D".process_material.scale = smoke_scale

func _physics_process(delta: float) -> void:
	modify_smoke_scale_by_distance()

func spawn_barrel() -> void:
	if total_barrels_spawned == spawn_end_on_nth_barrel:
		spawn_end()
		return
	var new_barrel = barrel_scene.instance()
	put_element_near_player(new_barrel)
	parent.call_deferred('add_child',new_barrel)
	if current_barrel != null:
		self.current_barrel.queue_free()
	self.current_barrel = new_barrel
	new_barrel.connect("spawn_new_barrel",self,"spawn_barrel")
	new_barrel.connect("warm_up",$"../Player", "warm_up")
	self.total_barrels_spawned += 1
	$"../Collectible Spawner".spawn_single_gem(current_barrel)
	
func put_element_near_player(element) -> void:
	var random_x_pos = random.randi_range(min_x_y_pos, max_x_y_pos)
	var random_y_pos = random.randi_range(min_x_y_pos, max_x_y_pos)
	# these ifs have 50% chance to make x or y negative
	if (random.randi_range(0,1)):
		random_x_pos *= -1
	if (random.randi_range(0,1)):
		random_y_pos *= -1
	var player_x_pox: int = $"../Player".position.x
	var player_y_pox: int = $"../Player".position.y
	element.position.x =  player_x_pox + random_x_pos
	element.position.y =  player_y_pox + random_y_pos
	
func spawn_end() -> void:
	var final_bonfire = level_end.instance()
	put_element_near_player(final_bonfire)
	parent.call_deferred("add_child", final_bonfire)
	self.current_barrel.queue_free()
	self.current_barrel = final_bonfire
	self.spawned_end = true
	
func scale_number_to_range(measurement_range_min: float, measurement_range_max: float, target_range_min: float, target_range_max:float, distance: float) -> float:
	var measure_min: float = 0
	var measure_max: float = Vector2(0,0).distance_to(Vector2(measurement_range_max,measurement_range_max))
	return abs((target_range_max-target_range_min) / (measure_max - measure_min) * (distance - measure_max) + target_range_max)

func calc_dist_barrel_player(barrel_pos: Vector2, player_pos: Vector2):
	return barrel_pos.distance_to(player_pos)
	
