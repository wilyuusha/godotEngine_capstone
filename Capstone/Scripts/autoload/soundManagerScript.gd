extends Node

const OPEN_INVENTORY = preload("res://Assets/Music/sfx/sfx_open_inventory.wav")
const OPEN_STATISTICS = preload("res://Assets/Music/sfx/sfx_open_statistics.wav")
const TAKE_DAMAGE = preload("res://Assets/Music/sfx/sfx_take_damange.wav")
const USED_POTION = preload("res://Assets/Music/sfx/sfx_healing/Cure1.wav")
const BUY_POTION = preload("res://Assets/Music/sfx/sfx_buy_potion.wav")
const SFX_GENERAL = preload("res://Assets/Music/sfx/sfx_opening_dialogue.wav")
const SFX_PORTAL = preload("res://Assets/Music/sfx/sfx_portal.wav")
const SFX_REQUIRED = preload("res://Assets/Music/sfx/sfx_required.wav")
const SFX_FOOTSTEP = preload("res://Assets/Music/sfx/sfx-cc0/quiver-leather-squeeze-01.wav")

onready var soundPlayer = $SoundPlayer

func play_sound(sound):
	for audioStreamPlayer in soundPlayer.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = sound
			audioStreamPlayer.play()
			break
