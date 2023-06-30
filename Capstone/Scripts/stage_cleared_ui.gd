extends CanvasLayer

onready var clear_time = $bg/Body/Clear
onready var quiz_answer= $bg/Body/Total
onready var saved_game_data = SaveLoadState.game_data

func _ready():
	# Display the current values.
	clear_time.text = "Clear time: " + str(Global.stage_total_time)
	quiz_answer.text = "Quiz Answered: " + str(Global.stage_score)

func _on_Town_pressed():
	# Go back to town.
	self.visible = false
	SceneTransition.play_transition_forward()
	get_tree().paused = true
	yield(SceneTransition, "transition_completed")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/City.tscn")
	SceneTransition.play_transition_backward()
	get_tree().paused = false
	yield(SceneTransition, "transition_completed")
	
