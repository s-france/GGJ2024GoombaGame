extends CharacterBody2D


@onready var coyoteTimer = $CoyoteJumpTimer 
@onready var jumpBufferTimer = $JumpBufferTimer
@onready var wall_jump_timer = $WallJumpTimer

var jumpAvailability: bool
var jumpBufferPressed: bool


const GRAVITY = 2000.0
const JUMPSPEED = -600.0
const speed = 400.0
const friction = 3800.0
const accel = 2000.0
const air_accel = 800.0
const air_friction = 1500.0

const max_jumps = 2
var current_jumps = 1

var double_jump_available = false
var was_wall_normal = Vector2.ZERO
var just_wall_jumped = false

func _physics_process(delta):
	

	
	gravitate(delta)
	var input_direction = Input.get_axis("left_2", "right_2") 
	
	accelerate(input_direction, delta)
	air_accelerate(input_direction, delta)
	deccelerate(input_direction, delta)
	air_resistance(input_direction, delta)
	#all of jump code:
	
	jump()
	wall_jump()
	
	
	var was_on_floor = is_on_floor()
	var was_on_wall = is_on_wall_only()
	
	if was_on_wall:
		was_wall_normal = get_wall_normal()
		
	move_and_slide()
	
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >=0 #last thing makes sure we don't account for regular jump
	
	if just_left_ledge:
		coyoteTimer.start()
		
	just_wall_jumped = false
	var just_left_wall = was_on_wall and not is_on_wall()
	if just_left_wall:
		wall_jump_timer.start()
	
	

	
		
	

func gravitate(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
func accelerate(direction, delta):
	if not is_on_floor(): return
	if direction !=0:
		velocity.x = move_toward(velocity.x, speed*direction, accel * delta)
	#velocity = velocity.limit_length(600)
	
func air_accelerate(direction, delta):
	if is_on_floor(): return
	if direction != 0:
		velocity.x = move_toward(velocity.x, speed*direction, air_accel * delta)
	
func deccelerate(direction, delta):
	if direction == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, friction * delta)

func air_resistance(direction, delta):
	if direction == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, air_friction * delta)

func jump():
	if is_on_floor():
		double_jump_available = true
	
	if Input.is_action_just_pressed("jump_2") and not is_on_floor():
		jumpBufferTimer.start()
		
	if is_on_floor() and !jumpBufferTimer.is_stopped():
			jumpBufferTimer.stop()
			velocity.y = JUMPSPEED
			
	elif is_on_floor() or coyoteTimer.time_left > 0.0:
		if Input.is_action_just_pressed("jump_2"):
			velocity.y = JUMPSPEED
			jumpBufferTimer.stop()
			coyoteTimer.stop()
			
	elif not is_on_floor():
		if Input.is_action_just_released("jump_2") and velocity.y < JUMPSPEED/2.0:
			velocity.y = JUMPSPEED/2.0
			
		if Input.is_action_just_pressed("jump_2") and double_jump_available and not just_wall_jumped:
			velocity.y = JUMPSPEED * 0.8
			double_jump_available = false
		
	
		
		

func wall_jump():
	if not is_on_wall_only() and wall_jump_timer.time_left <= 0.0: return
	
	var wall_normal = get_wall_normal() #gets a vector that points away from the wall
	if wall_jump_timer.time_left > 0.0:
		wall_normal = was_wall_normal
	if Input.is_action_just_pressed("jump_2"):
		velocity.x = wall_normal.x * speed
		velocity.y = JUMPSPEED
		wall_jump_timer.stop()
		just_wall_jumped = true
