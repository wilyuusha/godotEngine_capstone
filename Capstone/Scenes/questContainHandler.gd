extends VBoxContainer

const QuestLogs = preload("res://Scenes/QuestBorder.tscn")

func _process(delta):
	if get_child_count() == 0:
		var quest1 = QuestLogs.instance()
		self.add_child(quest1)
