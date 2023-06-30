extends Label

onready var gold_display = $"."

onready var saved_game_data = SaveLoadState.game_data

func _ready():
	gold_display.text =": " + str(saved_game_data.gold)
	
func _process(_delta):
	pass
