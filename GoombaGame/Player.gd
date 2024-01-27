extends CharacterBody2D

const speed = 400.0
const friction = 5000.0
const accel = 2000.0

func _physics_process(delta):
	
	var input_direction = Input.get_vector("left_1", "right_1", "up_1", "down_1") 
	
	player_movement(input_direction, delta)
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
