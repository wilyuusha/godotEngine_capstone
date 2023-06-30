extends Node2D

onready var correct_ans = $Panel/VBoxContainer/correct
onready var wrong_ans = $Panel/VBoxContainer/wrong
onready var total_ans = $Panel/VBoxContainer/total

onready var saved_game_data = SaveLoadState.game_data

func _ready():
	correct_ans.text = "Correct: " + str(saved_game_data.correct_answered)
	wrong_ans.text = "Incorrect: " + str(saved_game_data.wrong_answered)
	total_ans.text = "Total: " + str(saved_game_data.total_answered)
	
func _process(_delta):
	correct_ans.text = "Correct: " + str(saved_game_data.correct_answered)
	wrong_ans.text = "Incorrect: " + str(saved_game_data.wrong_answered)
	total_ans.text = "Total: " + str(saved_game_data.total_answered)
	
func _input(event):
	if event.is_action_pressed("statistics_close_ui"):
		#self.queue_free()
		self.visible = !self.visible
