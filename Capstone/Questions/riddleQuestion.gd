extends Area2D


var death = false
var active = false
var quiz_session_effects_scene = preload("res://Effects/quizSessionEffects.tscn")
onready var timer = $Timer
onready var lifebar = "res://Scenes/playerGUI/LifeBar.tscn"
onready var gui_interface = $"../../GUI"
onready var playerAnimation = $"../../Ysort/Player/sfx_effects"
onready var saved_game_data = SaveLoadState.game_data

func _ready():
# warning-ignore:return_value_discarded
	connect("body_entered", self, '_on_NPC_body_entered')
# warning-ignore:return_value_discarded
	connect("body_exited", self, '_on_NPC_body_exited')
	
	# rng question initialize
	Global.rng.randomize()
	
# warning-ignore:unused_argument
func _process(delta):
	$DialogicButton/AnimatedSprite.visible = active
	
func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("riddle_accept") and active:
			SoundManager.play_sound(SoundManager.SFX_GENERAL)
			initialize_question()
	
func initialize_question():
	timer.start()
	$sfx_tick_clock.play()
	initiate_particles_effects()
	get_tree().paused = true
	var dialog = Dialogic.start("riddle-"+str(Global.rng.randi_range(1, 10)))
	add_child(dialog)
	timer.pause_mode = Node.PAUSE_MODE_PROCESS
	dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	dialog.connect('dialogic_signal', self, 'riddle_answers')
	dialog.connect('timeline_end', self, 'unpause')
	
func initiate_particles_effects():
	var quiz_particles_node = quiz_session_effects_scene.instance()
	add_child(quiz_particles_node)
	
func _on_Timer_timeout():
	Global.camera.shake(0.2,5)
	SoundManager.play_sound(SoundManager.TAKE_DAMAGE)
	playerAnimation.play("damage_effects")
	# damage calculation.
	var total_timeout_damage = (Global.rng.randi_range(6, 12) - saved_game_data.damage_reduces)
	Global.Player_CurrentHP -= total_timeout_damage
	Global_OverlayNotify.show_notification("took " + str(total_timeout_damage) + " damage")
	
# warning-ignore:unused_argument
func unpause(timeline_name):
	timer.stop()
	$sfx_tick_clock.stop()
	get_tree().paused = false
	
func _on_NPC_body_entered(body):
	if body.name == 'Player':
		active = true
		
func _on_NPC_body_exited(body):
	if body.name == 'Player':
		active = false
		
func riddle_answers(choices):
	if choices == 'true':
		# gold_obtained
		var gold_obtained = Global.rng.randi_range(6, 12)
		saved_game_data.gold += gold_obtained
		Global_OverlayNotify.show_notification("Gold obtained: " + str(gold_obtained))
		# records
		Global.riddle_answered += 1
		SaveLoadState.save_data()
		self.queue_free()
	elif choices == 'false':
		Global.camera.shake(0.2,5)
		SoundManager.play_sound(SoundManager.TAKE_DAMAGE)
		# total damage
		var total_damage = (Global.rng.randi_range(14, 20) - saved_game_data.damage_reduces)
		Global.Player_CurrentHP -= total_damage
		# gold obtained
		var gold_obtained = 3
		saved_game_data.gold += gold_obtained
		Global_OverlayNotify.show_notification("Gold obtained: " + str(gold_obtained))
		# record
		Global.riddle_answered += 1
		SaveLoadState.save_data()
		self.queue_free()
