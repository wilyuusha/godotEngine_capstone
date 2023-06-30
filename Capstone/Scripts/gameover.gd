extends CanvasLayer

func _input(event):
	if event.is_action_pressed("gameover_btn"):
		get_tree().paused = false
		Global.Player_CurrentHP = 100
		Global.stage_score = 0
		Global.riddle_answered = 0
		get_tree().reload_current_scene()
