extends Node2D

var stage_cleared = false
onready var saved_game_data = SaveLoadState.game_data

func _ready():
	# Main Scenario Continue
	if saved_game_data.main_scenario_counter == 3:
		saved_game_data.main_scenario_counter = 4
	else:
		pass
		
func _process(delta):
	if saved_game_data.school_id == false:
		if Global.riddle_answered == 4:
			saved_game_data.school_id = true
			SaveLoadState.save_data()
			var dialog = Dialogic.start("School_Id")
			add_child(dialog)
			saved_game_data.main_scenario_counter = 5
			
	if Global.stage_score == 5 and stage_cleared == false:
		if saved_game_data.school_id == true:
			saved_game_data.main_scenario_counter = 6
			var dialog2 = Dialogic.start("main-6")
			add_child(dialog2)
			stage_cleared = true
	else:
		pass
			
func _on_Testing_Room_tree_exiting():
	if saved_game_data.cleared_stage_3_score <= Global.stage_score:
		saved_game_data.stage_school_id_cleared_times = 1
		saved_game_data.cleared_stage_3_score = Global.stage_score
		saved_game_data.cleared_stage_3_time = Global.stage_total_time
		SaveLoadState.save_data()
		
		Global.riddle_answered = 0
		Global.stage_score = 0
		Global.stage_total_time = 0
	else:
		Global.riddle_answered = 0
		Global.stage_score = 0
		Global.stage_total_time = 0
	
