extends Control

var item: Dictionary
var selected = false
var mouse_hovering = false

func _ready() -> void:
	Signals.inventory_updated.connect(update_background_color)
	if item:
		%Item.texture = item.item_sprite
		if len(item.crafting_ingredients) >= 1:
			%Ingredient1.texture = Items.items[item.crafting_ingredients[0][0]].item_sprite
			
	update_background_color()
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_click"):
		if mouse_hovering && not selected:
			selected = true
			Player.selected_crafting_item_id = item.id
		elif not mouse_hovering && selected:
			selected = false
			Player.selected_crafting_item_id = item.id
		update_background_color()

func update_background_color():
	if selected:
		$ColorRect.color = (Color(0, 0, 0, 0.3))
	else:
		$ColorRect.color = (Color(0, 0, 0, 0.15))

func _on_color_rect_mouse_entered() -> void:
	mouse_hovering = true

func _on_color_rect_mouse_exited() -> void:
	mouse_hovering = false
