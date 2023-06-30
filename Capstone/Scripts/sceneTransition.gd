extends CanvasLayer

onready var animationPlayer = $AnimationPlayer
signal transition_completed

func play_transition_forward():
	animationPlayer.play("fancy_transition_forward")
	
func play_transition_backward():
	animationPlayer.play("fancy_transition_backward")
	
func play_enter():
	pass
	
func play_exit():
	pass
	
# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("transition_completed")
