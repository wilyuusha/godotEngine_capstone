extends Area2D

var player_school_active = false
onready var saved_game_data = SaveLoadState.game_data

func _process(_delta):
	$TouchScreenButton.visible = player_school_active

func _input(event):
	if event.is_action_pressed("enter_building_btn") and player_school_active:
		if saved_game_data.school_id == true:
			AutoPositionsavedPosition.saved_position = get_parent().name
			SceneTransition.play_transition_forward()
			get_tree().paused = true
			yield(SceneTransition, "transition_completed")
			# Change Scene
			get_tree().change_scene("res://Scenes/" + self.name + ".tscn")
			SceneTransition.play_transition_backward()
			get_tree().paused = false
			yield(SceneTransition, "transition_completed")
		else:
			SoundManager.play_sound(SoundManager.SFX_REQUIRED)
			Global_OverlayNotify.show_notification("School ID require to enter.")
			
func _on_School_Portal_body_entered(body):
	if body.name == "Player":
		player_school_active = true
		print(player_school_active)

func _on_School_Portal_body_exited(body):
	if body.name == "Player":
		player_school_active = false
		print(player_school_active)
