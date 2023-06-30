extends Area2D

onready var saved_game_data = SaveLoadState.game_data

func _ready():
	pass

func _on_FirstTimeEnter_body_entered(body):
	if saved_game_data.game_entered_counter == 0:
		saved_game_data.game_entered_counter += 1
		get_tree().paused = true
		var dialog = Dialogic.start("main-1")
		add_child(dialog)
		dialog.pause_mode = Node.PAUSE_MODE_PROCESS
		dialog.connect('timeline_end', self, 'unpause')
		
func unpause(timeline_name):
	get_tree().paused = false
