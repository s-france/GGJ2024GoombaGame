class_name p2Controller
extends Node2D


var jump : bool = false
var L : bool = false
var R : bool = false

@onready var p0 = $"Player2-1"
@onready var p1 = $"Player2-2"
@onready var p2 = $"Player2-3"

var playeractive = load("res://assets/p2-3 active.png")
var playerinactive = load("res://assets/p2-3.png")




@onready var PlayerCharacters = [p0, p1, p2]
var PlayersAlive = [1, 1, 1]

@onready var currentPlayer : Player2 = p1
var playerIdx : int = 1


var input_direction : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	

func _physics_process(delta):
	L = Input.is_action_just_pressed("switch_to_left")
	R = Input.is_action_just_pressed("switch_to_right")
	
	input_direction = Input.get_vector("left_2", "right_2", "up_2", "down_2")
	
	if L:
		SwitchPlayers(-1)
	if R:
		SwitchPlayers(1)
	
	
func GetInputDirection():
	return input_direction
	

#player = 1 or -1 for right or left
func SwitchPlayers(player: int):
	currentPlayer.inControl = false 
	
	var oldIdx : int = playerIdx
	
	playerIdx = playerIdx + player
		
	if playerIdx < 0:
		playerIdx = 2
		
	if playerIdx > 2:
		playerIdx = 0
	
	while !PlayersAlive[playerIdx] and playerIdx != oldIdx:
	
		playerIdx = playerIdx + player
		
		if playerIdx < 0:
			playerIdx = 2
		
		if playerIdx > 2:
			playerIdx = 0
	
		
	currentPlayer = PlayerCharacters[playerIdx]
	
	
	currentPlayer.inControl = true
	

