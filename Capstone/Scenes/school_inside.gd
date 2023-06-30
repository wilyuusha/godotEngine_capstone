extends Node2D

onready var scenario_timer_asking = $Timer
onready var saved_game_data = SaveLoadState.game_data

func _ready():
	if saved_game_data.main_scenario_counter == 7:
		saved_game_data.main_scenario_counter = 8
		var dialog = Dialogic.start("main-8")
		add_child(dialog)
		dialog.connect('timeline_end', self, 'initiate_scenario_to_9')
	else:
		pass
		
	if saved_game_data.main_scenario_counter == 11:
		saved_game_data.main_scenario_counter = 12
		var dialog = Dialogic.start("main-12")
		add_child(dialog)
		
# warning-ignore:unused_argument
func initiate_scenario_to_9(timeline_name):
	scenario_timer_asking.start()
	
func _on_Timer_timeout():
	saved_game_data.main_scenario_counter = 9
	var dialog = Dialogic.start("main-9")
	add_child(dialog)
	dialog.connect('timeline_end', self ,'initiate_to_main_10')
	
# warning-ignore:unused_argument
func initiate_to_main_10(timeline_name):
	saved_game_data.main_scenario_counter = 10
