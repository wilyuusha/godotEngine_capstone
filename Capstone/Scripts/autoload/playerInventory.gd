extends Node

const NUM_INVEN_SLOTS = 15
onready var saved_game_data = SaveLoadState.game_data

var inventory = {
	#0: ["School_Id", 1]
	}
	
func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			inventory[item][1] += item_quantity
			return
			
	for i in range(NUM_INVEN_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			return
