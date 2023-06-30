extends Node2D

const SlotClass = preload("res://Scripts/slots.gd")
onready var inventory_slots = $TextureRect/GridContainer

# faked_inventory.
onready var school_id_item = $TextureRect/School_Id
onready var heart_item = $TextureRect/Heart_Id
onready var certificate_item = $TextureRect/Certificate_Id
onready var saved_game_data = SaveLoadState.game_data

# warning-ignore:unused_argument
func _process(delta):
	school_id_item.visible = saved_game_data.school_id
	heart_item.visible = saved_game_data.heart_id
	certificate_item.visible = saved_game_data.certificate_id

func _ready():
	initialize_inventory()

func _input(event):
	if event.is_action_pressed("close_ui"):
		self.queue_free()

func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])
			
