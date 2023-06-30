extends Node2D

onready var saved_game_data = SaveLoadState.game_data

func _ready():
	if saved_game_data.door_item_key == true:
		print("Key true")
	else:
		print("Dont have key")

func _on_the_assignment_stage_tree_exiting():
	if saved_game_data.cleared_stage_4_score <= Global.stage_score:
		saved_game_data.stage_the_assignments_cleared_times = 1
		saved_game_data.cleared_stage_4score = Global.stage_score
	else:
		pass
		
