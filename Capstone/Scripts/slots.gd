extends Panel

# Variable names
var default_tex = preload("res://Assets/Inventory/item_slot_default_background.png")
var empty_tex = preload("res://Assets/Inventory/item_slot_empty_background.png")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

var itemClass = preload("res://Scenes/Item.tscn")
var item = null

func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	refresh_style()

# to refresh the inventory.
func initialize_item(item_name, item_quantity):
	if item == null:
		item = itemClass.instance()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
	refresh_style()

# item border design.
func refresh_style():
	if item == null:
		set('custom_styles/panel', empty_style)
	else:
		set('custom_styles/panel', default_style)
		
