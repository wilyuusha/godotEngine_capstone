extends Area2D

var player_active = false

func _ready():
	#connect("body_entered", self, '_on_NPC_body_entered')
	#connect("body_exited", self, '_on_NPC_body_exited')
	pass
	
func _process(_delta):
	$TouchScreenButton.visible = player_active
	
func _input(event):
	if event.is_action_pressed("accept") and player_active:
		initiate_stage_selection()
	
func _on_Stage_Selection_Area2D_body_entered(body):
	if body.name == "Player":
		player_active = true
		
func _on_Stage_Selection_Area2D_body_exited(body):
	if body.name == "Player":
		player_active = false
		
func initiate_stage_selection():
	var stage_selection_scene = load("res://Scenes/Stage_Selection.tscn")
	var stage_selection_node = stage_selection_scene.instance()
	add_child(stage_selection_node)
	

