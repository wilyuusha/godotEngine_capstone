extends Node

var rng = RandomNumberGenerator.new()
var camera = null

onready var saved_game_data = SaveLoadState.game_data

# warning-ignore:unused_argument
func _process(delta):
	saved_game_data.main_scenario_entered = main_scenario_counter
	SaveLoadState.save_data()
	
# Main Hint Scenario
var main_scenario_counter = 0
var npc_talked = 0

# Player's Stats
var Player_MaxHP = 100
var Player_CurrentHP = 100

# Statistics
var riddle_answered = 0
var total_answered = 0
var correct_answered = 0
var wrong_answered = 0

# Stage Scores / Timer
var total_played_value = 0
var stage_score = 0
var stage_m = 0
var stage_s = 0
var stage_ms = 0
var stage_total_time = 0

# Resetting
func reset_initial_values():
	stage_total_time = 0
	stage_score = 0
	Player_CurrentHP = 100
