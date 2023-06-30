extends KinematicBody2D

var player_active = false
	
func _process(_delta):
	$TouchScreenButton.visible = player_active
	
func _input(event):
	if event.is_action_pressed("shop") and player_active:
		initiate_shop()
	
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player_active = true
		
func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player_active = false
		
func initiate_shop():
	var shop_interface_scene = load("res://Scenes/Shop_Interface.tscn")
	var shop_interface_node = shop_interface_scene.instance()
	add_child(shop_interface_node)
