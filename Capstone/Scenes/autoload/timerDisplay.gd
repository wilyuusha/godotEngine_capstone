extends Label

onready var time_display = $"."

onready var saved_game_data = SaveLoadState.game_data

func _ready():
	time_display.text = str(saved_game_data.global_hour) + ":" + str(saved_game_data.global_minute) + ":" + str(saved_game_data.global_second)

func _process(_delta):
	if saved_game_data.global_second > 59:
		saved_game_data.global_minute += 1
		saved_game_data.global_second = 0
		
	if saved_game_data.global_minute > 59:
		saved_game_data.global_hour += 1
		saved_game_data.global_minute = 0
	
	time_display.text = str(saved_game_data.global_hour) + ":" + str(saved_game_data.global_minute) + ":" + str(saved_game_data.global_second)
	SaveLoadState.save_data()
	
func _on_Timer_timeout():
	saved_game_data.global_second += 1
