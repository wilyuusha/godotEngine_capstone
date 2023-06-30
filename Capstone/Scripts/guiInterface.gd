extends CanvasLayer

onready var inventory_scene = preload("res://Scenes/Inventory.tscn")
onready var statistics_scene = preload("res://Scenes/Statistics.tscn")
onready var QuestLog = get_node("QuestContainHandler/QuestLogVBox")
onready var player = $"../Ysort/Player"
onready var hint_btn = $Main_Scenario_Tracker/Hint_btn
onready var saved_game_data = SaveLoadState.game_data

func _ready():
	pass

# warning-ignore:unused_argument
func _process(delta):
	if saved_game_data.main_scenario_counter == 10:
		hint_btn.visible = true
	else:
		hint_btn.visible = false
		
func _input(event):
	if event.is_action_pressed("inventory"):
		SoundManager.play_sound(SoundManager.OPEN_INVENTORY)
		var inventory_node = inventory_scene.instance()
		add_child(inventory_node)
		
	if event.is_action_pressed("statistics"):
		SoundManager.play_sound(SoundManager.OPEN_STATISTICS)
		$Statistics.visible = !$Statistics.visible
		
	if event.is_action_pressed("scenario_hint"):
		if saved_game_data.main_scenario_counter == saved_game_data.main_scenario_counter:
			SoundManager.play_sound(SoundManager.SFX_GENERAL)
			get_tree().paused = true
			var dialog = Dialogic.start("main-" + str(saved_game_data.main_scenario_counter))
			add_child(dialog)
			player.pause_mode = Node.PAUSE_MODE_STOP
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			
	if event.is_action_pressed("riddle_hint"):
		if saved_game_data.main_scenario_counter == 10:
			SoundManager.play_sound(SoundManager.SFX_GENERAL)
			var dialog = Dialogic.start("heart_hint")
			add_child(dialog)
			
func unpause(timeline_name):
	get_tree().paused = false
