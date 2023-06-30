extends Area2D

func _ready():
	pass
	
func _process(delta):
	if Global.stage_score == 4:
		$CollisionShape2D.disabled = false
		$AnimatedSprite.visible = true
		$AnimatedSprite.play("New Anim")
	else:
		$AnimatedSprite.visible = false
		$CollisionShape2D.disabled = true

func _on_stage_cleared_body_entered(body):
	if body.name == 'Player':
		print("Stage Cleared")
