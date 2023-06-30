extends Node2D

func _ready():
	$ColorRect/AnimationPlayer.play("fade_in")
	yield(get_tree().create_timer(4), "timeout")
	$ColorRect/AnimationPlayer.play("fade_out")
	yield(get_tree().create_timer(6), "timeout")
	get_tree().change_scene("res://Scenes/mainMenu/mainMenu.tscn")
