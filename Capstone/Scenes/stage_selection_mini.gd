extends CanvasLayer

onready var record_save_stage3_time = $"Stage_3/Stage 1-3/VBoxContainer/Record\'s detail/Saved Time"
onready var record_save_stage3_score = $"Stage_3/Stage 1-3/VBoxContainer/Record\'s detail/Saved Ans"
onready var record_save_stage4_score = $"Stage_4/Stage 1-4/VBoxContainer/Record\'s detail/Saved Ans 1-4"
onready var record_save_stage5_counter = $"Stage_5/Stage 1-5/VBoxContainer/Record\'s detail/Cleared times"
onready var animationPlayer = $stage_animation

onready var saved_game_data = SaveLoadState.game_data

func _ready():
	# Load the recorded value.
	record_save_stage3_time.text = "- Cleared Time: " + str(saved_game_data.cleared_stage_3_time)
	record_save_stage3_score.text = "- Question Answered: " + str(saved_game_data.cleared_stage_3_score) + " / 10"
	record_save_stage4_score.text = "- Question Answered: " + str(saved_game_data.cleared_stage_4_score) + " / 10"
	record_save_stage5_counter.text = "- Stage cleared counter: " + str(saved_game_data.stage_prove_worth_cleared_times)
	
############################################################ OPEN_MINI_MENU
func _on_Stage_11_pressed():
	SoundManager.play_sound(SoundManager.SFX_GENERAL)
	$Stage_1.visible = !$Stage_1.visible
	
func _on_Stage_12_pressed():
	SoundManager.play_sound(SoundManager.SFX_GENERAL)
	$Stage_2.visible = !$Stage_2.visible
	
func _on_Stage_13_pressed():
	SoundManager.play_sound(SoundManager.SFX_GENERAL)
	$Stage_3.visible = !$Stage_3.visible
	
func _on_Stage_14_pressed():
	SoundManager.play_sound(SoundManager.SFX_GENERAL)
	$Stage_4.visible = !$Stage_4.visible

func _on_Stage_15_pressed():
	SoundManager.play_sound(SoundManager.SFX_GENERAL)
	$Stage_5.visible = !$Stage_5.visible
	
############################################################ CHANGE_SCENE HANDLER
func _on_stage_11_start_pressed():
	self.visible = false
	SoundManager.play_sound(SoundManager.SFX_GENERAL)
	SceneTransition.play_transition_forward()
	yield(SceneTransition, "transition_completed")
	get_tree().change_scene("res://Scenes/Stages/Tutorial_Stage_1.tscn")
	SceneTransition.play_transition_backward()
	yield(SceneTransition, "transition_completed")
	
func _on_stage_12_start_pressed():
	SoundManager.play_sound(SoundManager.SFX_GENERAL)
	if saved_game_data.stage_1_1_cleared_times != 0:
		self.visible = false
		SceneTransition.play_transition_forward()
		yield(SceneTransition, "transition_completed")
		get_tree().change_scene("res://Scenes/Stages/Tutorial_Stage_2_Finale.tscn")
		SceneTransition.play_transition_backward()
		yield(SceneTransition, "transition_completed")
	else:
		SoundManager.play_sound(SoundManager.SFX_REQUIRED)
		Global_OverlayNotify.show_notification("You need clear Tutorial 1-1 stage.")
	
func _on_stage_13_start_pressed():
	SoundManager.play_sound(SoundManager.SFX_GENERAL)
	if saved_game_data.stage_1_2_cleared_times != 0:
		self.visible = false
		SceneTransition.play_transition_forward()
		yield(SceneTransition, "transition_completed")
		get_tree().change_scene("res://Scenes/TestingRoom.tscn")
		SceneTransition.play_transition_backward()
		yield(SceneTransition, "transition_completed")
	else:
		SoundManager.play_sound(SoundManager.SFX_REQUIRED)
		Global_OverlayNotify.show_notification("You need clear Tutorial 1-2 stage.")
	
func _on_stage_14_start_pressed():
	SoundManager.play_sound(SoundManager.SFX_GENERAL)
	if saved_game_data.stage_school_id_cleared_times != 0:
		if saved_game_data.main_scenario_counter >= 10:
			self.visible = false
			SceneTransition.play_transition_forward()
			yield(SceneTransition, "transition_completed")
			get_tree().change_scene("res://Scenes/Stages/the_assignment_stage.tscn")
			SceneTransition.play_transition_backward()
			yield(SceneTransition, "transition_completed")
		else:
			Global_OverlayNotify.show_notification("Go to School first.")
	else:
		SoundManager.play_sound(SoundManager.SFX_REQUIRED)
		Global_OverlayNotify.show_notification("You need to clear School ID stage.")
	
func _on_stage_15_start_pressed():
	SoundManager.play_sound(SoundManager.SFX_GENERAL)
	if saved_game_data.certificate_id == true:
		self.visible = false
		SceneTransition.play_transition_forward()
		yield(SceneTransition, "transition_completed")
		get_tree().change_scene("res://Scenes/Stages/worth.tscn")
		SceneTransition.play_transition_backward()
		yield(SceneTransition, "transition_completed")
	else:
		SoundManager.play_sound(SoundManager.SFX_REQUIRED)
		Global_OverlayNotify.show_notification("You need certificate to enter.")
	
############################################################ CLOSE_BUTTON HANDLER
func _on_Close_Stage_Selection_pressed():
	$".".queue_free()
	
func _on_Close_Scene_pressed():
	SoundManager.play_sound(SoundManager.SFX_GENERAL)
	$Stage_1.visible = !$Stage_1.visible
	
func _on_Close_Scene_2_pressed():
	SoundManager.play_sound(SoundManager.SFX_GENERAL)
	$Stage_2.visible = !$Stage_2.visible
	
func _on_Close_Scene_3_pressed():
	SoundManager.play_sound(SoundManager.SFX_GENERAL)
	$Stage_3.visible = !$Stage_3.visible
	
func _on_Close_Scene_4_pressed():
	SoundManager.play_sound(SoundManager.SFX_GENERAL)
	$Stage_4.visible = !$Stage_4.visible
	
func _on_Close_Scene_5_pressed():
	SoundManager.play_sound(SoundManager.SFX_GENERAL)
	$Stage_5.visible = !$Stage_5.visible
