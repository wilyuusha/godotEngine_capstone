extends ProgressBar

onready var tween = $Tween

func _ready():
	self.max_value = Global.Player_MaxHP
	self.value = Global.Player_CurrentHP
	
func _process(_delta):
	animate_lifebar(Global.Player_CurrentHP, self.value)
	get_node("HP_Label").text = "HP: " + str(Global.Player_CurrentHP) + " / " + str(Global.Player_MaxHP)
	
func animate_lifebar(start, end):
	tween.interpolate_property(self, "value", start, end, 0.7, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()
