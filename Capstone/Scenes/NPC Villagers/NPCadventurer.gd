extends StaticBody2D

var player_active = false
onready var saved_game_data = SaveLoadState.game_data

func _ready():
	pass 
	
func _process(delta):
	$TouchScreenButton.visible = player_active
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if saved_game_data.door_quest_inProgress == true and QuestHandler.door_quest_collected_items >= 3:
			saved_game_data.door_quest_inComplete = true
			saved_game_data.door_item_key = true
			var dialog = Dialogic.start("NPCAdventurer")
			add_child(dialog)
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
		elif $"../../..".name == "the_assignment_stage" and saved_game_data.door_quest_inProgress == true:
			var dialog = Dialogic.start("NPCAdventurer")
			add_child(dialog)
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
		elif saved_game_data.door_quest == false and saved_game_data.door_quest_inComplete == false and $"../../..".name == "the_assignment_stage":
			get_tree().paused = true
			var dialog = Dialogic.start("door_quest_initiator")
			add_child(dialog)
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('dialogic_signal', self, 'quiz_start')
			dialog.connect('timeline_end', self, 'unpause')
		else:
			var dialog = Dialogic.start("NPCAdventurer-2")
			add_child(dialog)
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			
func unpause(timeline_name):
	get_tree().paused = false
	if saved_game_data.door_quest_inComplete == true and saved_game_data.door_quest_inProgress == true:
		Global_OverlayNotify.show_notification("You obtained Key!")
		saved_game_data.door_quest_inProgress = false
	else:
		pass
	
func quiz_start(choices):
	if choices == "true":
		saved_game_data.door_quest_inProgress = true
	elif choices == "false":
		pass
	else:
		pass
	
func _on_Area2D_body_entered(body):
	if body.name ==  'Player':
		player_active = true
	
func _on_Area2D_body_exited(body):
	if body.name ==  'Player':
		player_active = false
