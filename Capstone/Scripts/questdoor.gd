extends StaticBody2D

var player_active = false

onready var saved_game_data = SaveLoadState.game_data

func _process(delta):
	$TouchScreenButton.visible = player_active
	
	if saved_game_data.door_already_unlocked == true:
		$DoorClosed.visible = false
		$DoorOpen.visible = true
		$CollisionShape2D.disabled = true
		$Area2D.monitoring = false
		
func _input(event):
	if event.is_action_pressed("open_door") and player_active:
		if saved_game_data.door_item_key == true and saved_game_data.door_quest_inComplete == true:
			$DoorClosed.visible = false
			$DoorOpen.visible = true
			$CollisionShape2D.disabled = true
			saved_game_data.door_already_unlocked = true
			SaveLoadState.save_data()
		else:
			Global_OverlayNotify.show_notification("Required a key to open")

func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		print("Entered")
		player_active = true
	
func _on_Area2D_body_exited(body):
	if body.name == 'Player':
		print("Exited")
		player_active = false
