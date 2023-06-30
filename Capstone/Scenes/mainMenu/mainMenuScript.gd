extends CanvasLayer
 
onready var animationPlayer = $AnimationPlayer
onready var saved_game_data = SaveLoadState.game_data

func _ready():
	animationPlayer.play("blinking")
	
func _input(event):
	if event.is_action_pressed("start"):
		
		animationPlayer.stop()
		SoundManager.play_sound(SoundManager.SFX_GENERAL)
		
		# Change scene.
		SceneTransition.play_transition_forward()
		yield(get_tree().create_timer(3), "timeout")
		get_tree().change_scene("res://Scenes/mcRoom.tscn")
		SceneTransition.play_transition_backward()
		yield(get_tree().create_timer(3), "timeout")

