class_name Player2
extends CharacterBody2D

@export var control : p2Controller


const speed = 400.0
const friction = 8000.0
const accel = 5000.0

var inControl : bool = false

func _physics_process(delta):
	
	if inControl:
		player_movement(control.input_direction, delta)
		move_and_slide()
	

func player_movement(input, delta):
	if input == Vector2.ZERO:
		if velocity.length() > (friction*delta):
			velocity -= velocity.normalized() * friction * delta
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity.limit_length(speed)
