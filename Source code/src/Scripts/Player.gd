extends Actor

signal player_death

onready var animation_player = $AnimationPlayer
onready var dead_sprite = load("res://Assets/dead sprite.png")
onready var coin_counter = $"CanvasLayer/Coin counter"
onready var frozen_bar = $CanvasLayer/FrozenBar
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVariables.player = self
	coin_counter.coins_gathered = GlobalVariables.coins_gathered
	$CanvasLayer/FrozenBar.connect("warmth_depleted", self, "player_dead")

#sprite position is constant it doesn't change
func _physics_process(delta: float) -> void:
	var horizontal_movement = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertical_movement = Input.get_action_strength("down") - Input.get_action_strength("up")
	var move_direction = Vector2(horizontal_movement, vertical_movement)
	if move_direction.x != 0 or move_direction.y != 0 :
		animation_player.play("Walking")
	else:
		animation_player.stop(false)
	move_and_collide(move_direction*4)

func player_dead()-> void:
	self.animation_player.stop(false)
	self.set_physics_process(false)
	$Particles2D.emitting = false
	$CanvasLayer/FrozenBar.disconnect("warmth_depleted", self, "player_dead")
	$CanvasLayer/FrozenBar/DecayTimer.stop()
	$"Alive sprite".hide()
	$"frozen death sprite".show()
	emit_signal('player_death')
	
func warm_up(finished:bool)-> void:
	if not finished:
		$CanvasLayer/FrozenBar/FillUpTimer.start()
		$CanvasLayer/FrozenBar/DecayTimer.stop()
	else:
		$CanvasLayer/FrozenBar/FillUpTimer.stop()
		$CanvasLayer/FrozenBar/DecayTimer.start()

func initialize_coins(n_coins: int) -> void:
	self.coin_counter.total_coins = n_coins

func increment_coin_count()-> void:
	self.coin_counter.increment_coin_count()

