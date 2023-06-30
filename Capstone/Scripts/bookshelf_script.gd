extends StaticBody2D

var player_active = false
onready var saved_game_data = SaveLoadState.game_data

func _ready():
	pass # Replace with function body.
	
func _process(delta):
	$TouchScreenButton.visible = player_active
	
func _input(event):
	if event.is_action_pressed("ui_accept") and player_active:
		get_tree().paused = true
		var dialog = Dialogic.start(self.name)
		add_child(dialog)
		dialog.pause_mode = Node.PAUSE_MODE_PROCESS
		dialog.connect('timeline_end', self, 'unpause')
	
func unpause(timeline_name):
	get_tree().paused = false
	
	if saved_game_data.bookshelf_talked_count <= 20:
		var gold_obtained = 4
		saved_game_data.gold += gold_obtained
		saved_game_data.bookshelf_talked_count += 1
		print(gold_obtained)
		SaveLoadState.save_data()
		Global_OverlayNotify.show_notification("Gold obtained: " + str(gold_obtained))
	else:
		# do nothing
		pass
	
func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		player_active = true
	
func _on_Area2D_body_exited(body):
	if body.name == 'Player':
		player_active = false
