extends Node2D

onready var stageClearedUI = preload("res://Scenes/Stage_Cleared_UI.tscn")

var complete = false
var player_active = false

onready  var interface = $"../GUI"
onready var stageCleared = $Stage_Cleared

func _ready():
	# Disabled at start
	stageCleared.visible = false
	
func _process(_delta):
	# Effecet lit up if stage is cleared!
	if Global.stage_score == 1:
		$Left_Lit.visible = true
	elif Global.stage_score == 2:
		$Left_Lit.visible = true
		$Upper_Lit.visible = true
	elif Global.stage_score == 3:
		$Left_Lit.visible = true
		$Upper_Lit.visible = true
		$Bottom_Lit.visible = true
	elif Global.stage_score == 4:
		$Left_Lit.visible = true
		$Upper_Lit.visible = true
		$Bottom_Lit.visible = true
		$Right_Lit.visible = true
	elif Global.stage_score == 5:
		$Left_Lit.visible = true
		$Upper_Lit.visible = true
		$Bottom_Lit.visible = true
		$Right_Lit.visible = true
		stageCleared.monitoring = true
		stageCleared.visible = true
	else:
		pass
		
	$Stage_Cleared/Stage_Cleared_Button/AnimatedSprite.visible = player_active
	
func _input(event):
	if event.is_action_pressed("finish") and player_active:
		print("Stage Cleared!")
		initiate_stageUI()
	
func _on_Stage_Cleared_body_entered(body):
	if body.name == "Player":
		player_active = true
	
func _on_Stage_Cleared_body_exited(body):
	if body.name == "Player":
		player_active = false
		
func initiate_stageUI():
	interface.queue_free()
	var stageClearedUI_scene = preload("res://Scenes/Stage_Cleared_UI.tscn")
	var stageClearedUI_node = stageClearedUI_scene.instance()
	add_child(stageClearedUI_node)
	
