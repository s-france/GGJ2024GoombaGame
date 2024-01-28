extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/OK.grab_focus()


func _on_ok_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
