extends Node2D

var stage_1_2_cleared_times = 0
onready var saved_game_data = SaveLoadState.game_data

func _ready():
	Global.stage_score = 4
	
func _on_Tutoral_Stage_2_Finale_tree_exiting():
	Global.stage_score = 0
	stage_1_2_cleared_times += 1
	saved_game_data.stage_1_2_cleared_times = stage_1_2_cleared_times
	SaveLoadState.save_data()
