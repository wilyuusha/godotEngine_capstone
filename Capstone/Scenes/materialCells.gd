extends StaticBody2D

var player_active = false
onready var saved_game_data = SaveLoadState.game_data

func _process(delta):
	$TouchScreenButton.visible = player_active

func _input(event):
	if event.is_action_pressed("collect_item") and player_active:
		if saved_game_data.door_quest_inProgress == true:
			if QuestHandler.door_quest_collected_items <= 4:
				QuestHandler.door_quest_collected_items += 1
				self.queue_free()
				Global_OverlayNotify.show_notification("Obtained cells")
			else:
				Global_OverlayNotify.show_notification("You have collected enough")
		else:
			Global_OverlayNotify.show_notification("A quest is needed to obtained the item")
	
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player_active = true
	
func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player_active = false
