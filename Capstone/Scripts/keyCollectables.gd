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
	item_name = "Key2"
	
func _process(delta):
	if being_picked_up == false:
		pass
	else:
		PlayerInventory.add_item(item_name, 1)
		get_tree().paused = true
		var dialog = Dialogic.start('keyChest')
		add_child(dialog)
		dialog.pause_mode = Node.PAUSE_MODE_PROCESS
		dialog.connect('timeline_end', self,  'unpause')
		
		
func unpause(timeline_name):
	get_tree().paused = false
	queue_free()
	
func pick_up_item(body):
	player = body
	being_picked_up = true
