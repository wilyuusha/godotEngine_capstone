extends VBoxContainer

onready var current_potion = $Potion/Potion_Left
onready var saved_game_data = SaveLoadState.game_data

func _ready():
	current_potion.text = str(saved_game_data.current_potion)
	
func _process(_delta):
	current_potion.text = str(saved_game_data.current_potion)
