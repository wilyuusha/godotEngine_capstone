extends KinematicBody2D

const ACCELERATION = 450
const MAX_SPEED = 120
const FRICTION  = 650
var velocity = Vector2.ZERO
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var saved_game_data = SaveLoadState.game_data
onready var gui_interface = $"../../GUI"

func _ready():
	Global.rng.randomize()
	
func _process(delta):
	if Global.Player_CurrentHP <= 0:
		gui_interface.queue_free()
		show_game_over()
		
func dmg_sfx():
	animationPlayer.play("damage_effects")
	
func _physics_process(delta):
	# Player's Movement
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		# apply walk sfx
		animationTree.set("parameters/idleAnimation/blend_position", input_vector)
		animationTree.set("parameters/runAnimation/blend_position", input_vector)	
		animationState.travel("runAnimation")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
				
	else:
		animationState.travel("idleAnimation")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
	
func _input(event):
	# Pickup system
	if event.is_action_pressed("pickup"):
		if $pickupZone.items_in_range.size() > 0:
			var pickup_item = $pickupZone.items_in_range.values()[0]
			pickup_item.pick_up_item(self)
			$pickupZone.items_in_range.erase(pickup_item)
			
	# Use potion.
	if event.is_action_pressed("potion"):
		use_potion()
		
func show_game_over():
	# load the game over scene
	saved_game_data.death_counter += 1
	SaveLoadState.save_data()
	var game_over_scene = load("res://Scenes/GameOver.tscn")
	var game_over_node = game_over_scene.instance()
	add_child(game_over_node)
	
	# pause the game
	set_process(false)
	set_physics_process(false)
	
func use_potion():
	# change condition.
	if saved_game_data.current_potion != 0:
		if Global.Player_CurrentHP < 76:
			SoundManager.play_sound(SoundManager.USED_POTION)
			saved_game_data.current_potion -= 1
			# healing calculation.
			var total_heal = (Global.rng.randi_range(14, 25) + saved_game_data.enhance_potion_value)
			Global.Player_CurrentHP += total_heal
		else:
			Global_OverlayNotify.show_notification("HP almost full.")
	else:
		Global_OverlayNotify.show_notification("Not enough potion.")
