extends Area2D

onready var timer = $Timer
var active = false

var quiz_session_effects_scene = preload("res://Effects/quizSessionEffects.tscn")
onready var lifebar = "res://Scenes/playerGUI/LifeBar.tscn"
onready var sfx_tick_clock = $sfx_tick_clock
onready var gui_interface = $"../GUI"
onready var playerAnimation = $"../Ysort/Player/sfx_effects"
onready var bgm_music = $"../AudioStreamPlayer"
onready var saved_game_data = SaveLoadState.game_data

func _ready():
	# rng question initialize$"../AudioStreamPlayer"
	Global.rng.randomize()
	
# warning-ignore:unused_argument
func _process(delta):
	$DialogicBtn.visible = active
	
func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("ui_accept") and active:
			SoundManager.play_sound(SoundManager.SFX_GENERAL)
			initialize_question()
	
func initialize_question():
	# initiate sfx and gfx
	active = false
	bgm_music.play()
	timer.start()
	sfx_tick_clock.play()
	initiate_particles_effects()
	# dialog
	get_tree().paused = true
	var dialog = Dialogic.start("final_quiz_1")
	add_child(dialog)
	timer.pause_mode = Node.PAUSE_MODE_PROCESS
	dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	dialog.connect('dialogic_signal', self, 'final_quiz_session')
	dialog.connect('timeline_end', self, 'unpause')
	
func unpause(timeline_name):
	get_tree().paused = false
	bgm_music.stop()
	timer.stop()
	sfx_tick_clock.stop()
	saved_game_data.stage_prove_worth_cleared_times += 1
	SaveLoadState.save_data()
	queue_free()
	
func initiate_particles_effects():
	var quiz_particles_node = quiz_session_effects_scene.instance()
	add_child(quiz_particles_node)
	
func _on_Timer_timeout():
	Global.camera.shake(0.2,8)
	SoundManager.play_sound(SoundManager.TAKE_DAMAGE)
	playerAnimation.play("damage_effects")
	# damage calculation.
	var total_timeout_damage = (Global.rng.randi_range(10, 22) - saved_game_data.damage_reduces)
	Global.Player_CurrentHP -= total_timeout_damage
	
func _on_FINAL_QUIZ_body_entered(body):
	if body.name == 'Player':
		active = true
		
func _on_FINAL_QUIZ_body_exited(body):
	if body.name == 'Player':
		active = false
	
func final_quiz_session(choices):
	if choices == 'true':
		# gold obtained
		var gold_obtained = Global.rng.randi_range(3, 8)
		saved_game_data.gold += gold_obtained
		Global_OverlayNotify.show_notification("Gold obtained: " + str(gold_obtained))
		# records
		saved_game_data.correct_answered += 1
		saved_game_data.total_answered += 1
		SaveLoadState.save_data()
	elif choices == 'false':
		Global.camera.shake(0.2,8)
		SoundManager.play_sound(SoundManager.TAKE_DAMAGE)
		# calculation
		var total_wrong_damage = (Global.rng.randi_range(13, 20) - saved_game_data.damage_reduces)
		Global.Player_CurrentHP -= total_wrong_damage
		Global_OverlayNotify.show_notification("Took: " + str(total_wrong_damage) + " damage")
		# gold obtained
		var gold_obtained = 3
		saved_game_data.gold += gold_obtained
		Global_OverlayNotify.show_notification("Gold obtained: " + str(gold_obtained))
		# records
		saved_game_data.wrong_answered += 1
		saved_game_data.total_answered += 1
		SaveLoadState.save_data()
