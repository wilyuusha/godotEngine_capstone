extends CanvasLayer

onready var gold_display = $TextureRect/gold_display/Gold
onready var shop_ui = $"."

onready var saved_game_data = SaveLoadState.game_data

func _ready():
	gold_display.text =": " + str(saved_game_data.gold)
	
# warning-ignore:unused_argument
func _process(delta):
	gold_display.text =": " + str(saved_game_data.gold)
	
func _on_CloseScene_pressed():
	shop_ui.queue_free()

# buy potion.
func _on_potion_btn_pressed():
	if saved_game_data.gold >= 4:
		Global_OverlayNotify.show_notification("Bought")
		SoundManager.play_sound(SoundManager.BUY_POTION)
		saved_game_data.current_potion += 1
		saved_game_data.gold -= 4
	else:
		Global_OverlayNotify.show_notification("You don't have enough gold.")

# buy potion enhancement
func _on_enhance_btn_pressed():
	if saved_game_data.gold >= 12:
		if saved_game_data.enhance_buy_limit <= 4:
			Global_OverlayNotify.show_notification("Bought")
			SoundManager.play_sound(SoundManager.BUY_POTION)
			saved_game_data.enhance_potion_value += 2
			saved_game_data.enhance_buy_limit += 1
			saved_game_data.gold -= 8
		else:
			Global_OverlayNotify.show_notification("You have reached the limit.")
	else:
		Global_OverlayNotify.show_notification("You don't have enough gold.")
		
# buy armor enhancement
func _on_armor_btn_pressed():
	if saved_game_data.gold >= 12:
		if saved_game_data.armor_buy_limit <= 4:
			Global_OverlayNotify.show_notification("Bought")
			SoundManager.play_sound(SoundManager.BUY_POTION)
			saved_game_data.damage_reduces += 1
			saved_game_data.armor_buy_limit += 1
			saved_game_data.gold -= 8
		else:
			Global_OverlayNotify.show_notification("You don't have enough gold.")
	else:
		Global_OverlayNotify.show_notification("You don't have enough gold.")
	


