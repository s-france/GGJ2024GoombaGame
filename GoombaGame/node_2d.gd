extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$play.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	get_tree().quit()
	
func _on_play_pressed():
	get_tree().change_scene_to_file("res://scene2D.tscn")


func _on_instructions_pressed():
	$Instructions.visible = true
	$Instructions/back.grab_focus()


func _on_credits_pressed():
	$Credits.visible = true
	$Credits/back2.grab_focus()

func _on_back_pressed():
	$Instructions.visible = false 
	$Credits.visible = false
	$play.grab_focus()
