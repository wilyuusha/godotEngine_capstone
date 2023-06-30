extends Node2D

onready var interface = $GUI
onready var saved_game_data = SaveLoadState.game_data

func _ready():
	# Display GUI at start 
	interface.visible = true
	
	if saved_game_data.main_scenario_counter == 6:
		saved_game_data.main_scenario_counter = 7
	else:
		pass
	
	# Global Positioning
	if AutoPositionsavedPosition.saved_position != null:
		get_node("Ysort/Player").set_position(get_node(AutoPositionsavedPosition.saved_position + "Pos").position)
		
func _on_mcRoom_tree_exiting():
	if saved_game_data.main_scenario_counter == 1:
		saved_game_data.main_scenario_counter = 2
		saved_game_data.game_entered_counter = 1
	else:
		pass
		
func _on_City_tree_entered():
	saved_game_data.school_id = true
