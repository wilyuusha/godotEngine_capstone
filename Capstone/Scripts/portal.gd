extends Area2D

func _on_Area2D_body_entered(_body):
	# Save your position
	AutoPositionsavedPosition.saved_position = get_parent().name
	
	# Screen Transition
	SceneTransition.play_transition_forward()
	get_tree().paused = true
	yield(SceneTransition, "transition_completed")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/" + self.name + ".tscn")
	SceneTransition.play_transition_backward()
	get_tree().paused = false
	yield(SceneTransition, "transition_completed")
