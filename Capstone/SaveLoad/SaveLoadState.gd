extends Node

const SAVE_FILE_PATH = "user://save_file.save"
var game_data = {}

func _ready():
	load_data()
	
func save_data():
	var file = File.new()
	file.open(SAVE_FILE_PATH, File.WRITE)
	file.store_var(game_data)
	file.close()
	
func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE_PATH):
		game_data = {
			"death_counter": 0,
			"bookshelf_talked_count": 0,
			"npc_talked_town1": 0,
			"damage_reduces": 0,
			"enhance_potion_value": 0,
			"armor_buy_limit": 0,
			"enhance_buy_limit": 0,
			"game_entered_counter": 0,
			"main_scenario_counter": 1,
			"NPCrandom_count": 0,
			"school_id": false,
			"heart_id": false,
			"certificate_id": false,
			"door_quest": false,
			"door_quest_collected": 0,
			"door_quest_inProgress": false,
			"door_quest_inComplete": false,
			"door_quest_count": 0,
			"door_already_unlocked": false,
			"door_item_key": false,
			"gold": 10,
			"correct_answered": 0,
			"wrong_answered": 0,
			"total_answered": 0,
			"global_hour": 0,
			"global_minute": 0,
			"global_second": 0,
			"cleared_stage_3_score": 0,
			"cleared_stage_3_time": 0,
			"cleared_stage_4_score": 0,
			"player_current_hp": 0,
			"current_potion": 1,
			"stage_1_1_cleared_times": 0,
			"stage_1_2_cleared_times": 0,
			"stage_school_id_cleared_times": 0,
			"stage_the_assignments_cleared_times": 0,
			"stage_prove_worth_cleared_times": 0,
		}
		save_data()
	file.open(SAVE_FILE_PATH, File.READ)
	game_data = file.get_var()
	file.close()
