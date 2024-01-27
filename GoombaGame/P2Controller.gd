class_name p2Controller
extends Node2D


var input_direction : float = 0
var jump : bool = false



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	

func _physics_process(delta):
	input_direction = Input.get_axis("left_2", "right_2")
	jump = Input.is_action_just_pressed("jump_2")
	
	
	
func GetInputDirection():
	return input_direction
	

