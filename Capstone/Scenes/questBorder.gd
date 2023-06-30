extends Panel

onready var QuestText = $QuestText
onready var saved_game_data = SaveLoadState.game_data

func _process(delta):
	if saved_game_data.door_quest == false:
		if saved_game_data.door_quest_inProgress:
			QuestText.text = "Material Collected: " + str(QuestHandler.door_quest_collected_items)
		elif saved_game_data.door_quest_inComplete:
			QuestText.text = "No active quest"
		else:
			QuestText.text = "No active quest"
			
	else:
		QuestText.text = "No active quest"
