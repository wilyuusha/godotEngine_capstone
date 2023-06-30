extends CanvasLayer

onready var label = $Label
onready var timer = $Timer
onready var colorReact = $ColorRect

func _ready():
	visible = false

func show_notification(message):
	label.text = message
	
	visible = true
	timer.start()

func _on_Timer_timeout():
	visible = false
