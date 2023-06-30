extends StaticBody2D

var player_active = false

func _process(delta):
	$TouchScreenButton.visible = player_active
	
func _input(event):
	if event.is_action_pressed("ui_accept") and player_active:
		get_tree().paused = true
		var dialog = Dialogic.start("NPCMartha")
		add_child(dialog)
		dialog.pause_mode = Node.PAUSE_MODE_PROCESS
		dialog.connect('timeline_end', self, 'unpause')
		
func unpause(timeline_name):
	get_tree().paused = false
	
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player_active = true
		
func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player_active = false
