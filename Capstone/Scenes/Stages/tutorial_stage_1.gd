extends Node2D

onready var tutorial_enter = $Dialogic/tutorial_enter
onready var main_bgm = $AudioStreamPlayer
onready var questions = get_node("Dialogic/normalQuestion")
onready var saved_game_data = SaveLoadState.game_data

func _ready():
	main_bgm.pause_mode = Node.PAUSE_MODE_PROCESS
	
func _on_tutorial_enter_body_entered(body):
	get_tree().paused = true
	var dialog = Dialogic.start("tutorial-enter")
	add_child(dialog)
	dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	dialog.connect('timeline_end', self,  'unpause')
	
func unpause(timeline_name):
	get_tree().paused = false
	tutorial_enter.monitorable = false
	
func _on_Tutorial_Stage_1_tree_exiting():
	Global.stage_score = 0
	saved_game_data.stage_1_1_cleared_times += 1
	SaveLoadState.save_data()
