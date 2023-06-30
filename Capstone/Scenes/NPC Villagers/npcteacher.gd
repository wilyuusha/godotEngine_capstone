extends StaticBody2D

var player_active = false
onready var touchscreenbtn = $TouchScreenButton
onready var saved_game_data = SaveLoadState.game_data
onready var root_scene = $"../../.."

func _ready():
	pass
	
func _process(_delta):
	touchscreenbtn.visible = player_active
	
func _input(event):
	if event.is_action_pressed("ui_accept") and player_active:
		if saved_game_data.main_scenario_counter == 12:
			saved_game_data.main_scenario_counter = 13
			get_tree().paused = true
			var dialog = Dialogic.start("main-13")
			add_child(dialog)
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'initiate_scenario_to_14')
		elif root_scene.name == "worth":
			var dialog = Dialogic.start("support-teacher")
			add_child(dialog)
			dialog.pause_mode = PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpausing_dialog')
		else:
			var dialog = Dialogic.start(self.name)
			add_child(dialog)
			dialog.pause_mode = PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpausing_dialog')
			
# warning-ignore:unused_argument
func initiate_scenario_to_14(timeline_name):
	saved_game_data.main_scenario_counter = 14
	get_tree().paused = false
	saved_game_data.certificate_id = true
	var dialog = Dialogic.start("Certificate_Id")
	add_child(dialog)
	SaveLoadState.save_data()
	
func unpausing_dialog(timeline_name):
	get_tree().paused = false
	
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player_active = true
		
func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player_active = false
