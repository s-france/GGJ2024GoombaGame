extends CharacterBody2D

const speed = 1800.0
const friction = 8000.0
const accel = 5.0

var col_amount = 0

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
		velocity += (((speed*input) - velocity) * accel * delta)
		
		
		velocity.limit_length(speed)

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is Player2:
			col_amount += 1
			if col_amount == 3:
				get_tree().reload_current_scene()
				
			KillPlayer(collision, collision.get_collider())
			
			
			
func KillPlayer(collision, player: Player2):
	player.control.PlayersAlive[player.idx] = 0
	player.control.SwitchPlayers(1)
	
	collision.get_collider().queue_free()
