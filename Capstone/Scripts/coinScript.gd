extends Area2D

var being_picked_up = false

#func _on_CoinArea_body_entered(body: Node) -> void:
func _on_CoinArea_body_entered(body):
	SoundManager.play_sound(SoundManager.COIN_COLLECT)
	Currency.update_gold(1)
	queue_free()
