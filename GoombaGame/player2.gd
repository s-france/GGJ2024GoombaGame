class_name Player2
extends CharacterBody2D

@export var control : p2Controller


const speed = 2400.0
const friction = 9000.0
const accel = 8.0

@export var idx : int


var inControl : bool = false


func _ready():
	if idx == 1:
		inControl = true

func _physics_process(delta):
	
	if inControl:
		player_movement(control.input_direction.normalized(), delta)
		move_and_slide()
	

func player_movement(input, delta):
	if input == Vector2.ZERO:
		if velocity.length() > (friction*delta):
			velocity -= velocity.normalized() * friction * delta
		else:
			velocity = Vector2.ZERO
	else:
		
		velocity += (((speed*input) - velocity) * accel * delta)
		velocity.limit_length(speed)
