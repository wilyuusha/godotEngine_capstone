extends StaticBody2D

var player_active = false

func _ready():
	#connect("body_entered", self, '_on_Area2D_body_entered')
	#connect("body_exited", self, '_on_Area2D_body_exited')
	pass
	
# warning-ignore:unused_argument
func _process(delta):
	$ui_accept/AnimatedSprite.visible = player_active
	
func _input(event):
	if event.is_action_pressed("ui_accept") and player_active:
		get_tree().paused = true
		var dialog = Dialogic.start(self.name)
		add_child(dialog)
		dialog.pause_mode = Node.PAUSE_MODE_PROCESS
		dialog.connect('timeline_end', self, 'unpause')
			
# warning-ignore:unused_argument
func unpause(timeline_name):
	get_tree().paused = false

func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		player_active = true

func _on_Area2D_body_exited(body):
	if body.name == 'Player':
		player_active = false
