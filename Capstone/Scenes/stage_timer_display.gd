extends Label

func _process(delta):
	if Global.stage_ms > 59:
		Global.stage_s += 1
		Global.stage_ms = 0
		
	if Global.stage_s > 59:
		Global.stage_m += 1
		Global.stage_s = 0
		
	# Store the value of the timer into singleton
	Global.stage_total_time = str(Global.stage_m)+":"+str(Global.stage_s)+":"+str(Global.stage_ms)
	
	# Display the Timer.
	self.text = str(Global.stage_m)+":"+str(Global.stage_s)+":"+str(Global.stage_ms)
	
func _on_Timer_timeout():
	Global.stage_ms += 01
