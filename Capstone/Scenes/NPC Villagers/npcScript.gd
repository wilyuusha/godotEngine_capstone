extends StaticBody2D

var player_active = false
onready var PathFollowAnim = $"../../../Path2D/PathFollow2D/PathFollowCam/PathFollowAnim"
onready var saved_game_data = SaveLoadState.game_data

func _process(_delta):
	$TouchScreenButton.visible = player_active

func _input(event):
	if event.is_action_pressed("ui_accept") and player_active:
		if self.name == "NPCrandom" and saved_game_data.NPCrandom_count == 0:
			var dialog = Dialogic.start("NPCrandom")
			add_child(dialog)
			dialog.connect('timeline_end', self, 'execute_pathfollowCam')
		elif self.name == "NPCrandom" and saved_game_data.main_scenario_counter == 7:
			get_tree().paused = true
			var dialog = Dialogic.start("NPCrandom-late")
			add_child(dialog)
			dialog.pause_mode = PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
		elif self.name == "NPCrandom" and saved_game_data.NPCrandom_count == 1:
			get_tree().paused = true
			var dialog = Dialogic.start("NPCrandom-2")
			add_child(dialog)
			dialog.pause_mode = PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
		else:
			get_tree().paused = true
			var dialog = Dialogic.start(self.name)
			add_child(dialog)
			dialog.pause_mode = PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			
func unpause(timeline_name):
	get_tree().paused = false
	
	if saved_game_data.npc_talked_town1 < 5:
		saved_game_data.npc_talked_town1 += 1
		var gold_obtained = 3
		saved_game_data.gold += gold_obtained
		Global_OverlayNotify.show_notification("Gold obtained: " + str(gold_obtained))
		SaveLoadState.save_data()
	else:
		pass
			
func execute_pathfollowCam(timeline_name):
	PathFollowAnim.play("show_portal")
	saved_game_data.NPCrandom_count = 1
	saved_game_data.main_scenario_counter = 3

func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		player_active = true
		
func _on_Area2D_body_exited(body):
	if body.name == 'Player':
		player_active = false
