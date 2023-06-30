extends KinematicBody2D

# Constant
const ACCELERATION = 460
const MAX_SPEED = 225

# Variables
var item_name
var velocity = Vector2.ZERO

var player = null
var being_picked_up = false

func _ready():
	item_name = "Potion"
	
func _process(delta):
	if being_picked_up == false:
		pass
	else:
		$opened.visible = true
		PlayerInventory.add_item(item_name, 1)
		queue_free()
		
func pick_up_item(body):
	player = body
	being_picked_up = true
