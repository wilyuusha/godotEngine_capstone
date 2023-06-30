extends StaticBody2D

var player_active = false
onready var _area = $Area2D
onready var saved_game_data = SaveLoadState.game_data

# warning-ignore:unused_argument
func _process(delta):
	if saved_game_data.main_scenario_counter == 10:
		$TouchScreenButton.visible = player_active
	else:
		$TouchScreenButton.visible = false

func _input(event):
	if event.is_action_pressed("ui_accept") and player_active:
		if saved_game_data.heart_id == false and saved_game_data.main_scenario_counter == 10:
			saved_game_data.heart_id = true
			var dialog = Dialogic.start("Heart_Id")
			add_child(dialog)
			saved_game_data.main_scenario_counter = 11
			SaveLoadState.save_data()
			_area.monitoring = false
		else:
			pass
		

func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		print("Entered")
		player_active = true
	
func _on_Area2D_body_exited(body):
	if body.name == 'Player':
		print("Exited")
		player_active = false
