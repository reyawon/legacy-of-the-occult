extends Control
class_name InventorySlotUI

signal slot_hovered(slot_index: int, entered: bool)

@onready var item: InventoryItem
@onready var icon: TextureRect = $Icon
var occupied: bool = false
var slot_index: int
var was_successfully_dropped: bool = false

func _ready() -> void:
	if item:
		icon.texture = item.texture
		occupied = true
		icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	mouse_filter = Control.MOUSE_FILTER_PASS
	
	if icon:
		icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
	mouse_exited.connect(_on_mouse_exit)
	
func on_update_item() -> void:
	print('updated item')
	if item:
		icon.texture = item.texture
		icon.visible = true
		
func _hide() -> void:
	icon.visible = false
	
func _show() -> void:
	icon.visible = true
	
func _get_drag_data(_at_position: Vector2) -> Variant:
	if item == null:
		return null
		
	var preview = _create_preview(icon.texture, 0.4)
	_hide()
	
	#reset flag
	was_successfully_dropped = false
	set_drag_preview(preview)
	
	return {"src": slot_index, "item": item}
	
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	#Validate data
	if typeof(data) != TYPE_DICTIONARY:
		return false
	if not data.has("src") or not data.has("item"):
		return false
		
	#Validate types
	if typeof(data["src"]) != TYPE_INT:
		return false
	var incoming_item = data["item"]
	if incoming_item == null:
		return false
		
	#Validate occupancy
	if occupied:
		return false
		
	print('true')
	return true
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var target_index = slot_index
	print('dropped in slot: ', target_index)
	
	var origin_index = data['src']
	var dragged_item = data['item']
	var grid = get_parent()
	var origin_slot = grid.get_node("slot_%d" % origin_index)
	
	print('dragged ', dragged_item.name, ' from slot: ', origin_index, ' to ', target_index)
	
	var inv_model: InventoryModel
	inv_model = get_parent().get_parent()
	inv_model.move_item(origin_index, target_index)
	
	#mark as succesfully dropped
	origin_slot.was_successfully_dropped = true
	
func _create_preview(tex: Texture2D, scale_factor: float) -> TextureRect:
	var preview := TextureRect.new()
	preview.texture = tex
	
	preview.set_anchors_and_offsets_preset(Control.PRESET_TOP_LEFT)
	preview.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP
	
	#raw texture size
	var tex_size := tex.get_size()
	preview.size = tex_size
	
	
	#centering math
	var bias := Vector2(-250, -250)
	preview.pivot_offset = tex_size * 0.5 + bias
	preview.scale = Vector2(scale_factor, scale_factor)
	preview.position = -preview.pivot_offset * preview.scale
	
	#Draw above everything
	preview.top_level = true
	preview.z_as_relative = false
	preview.z_index = 4096
	
	return preview
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END and not was_successfully_dropped:
		icon.visible = (item != null)
		
func _on_mouse_enter() -> void:
	emit_signal("slot_hovered", slot_index, true)
	
func _on_mouse_exit() -> void:
	emit_signal("slot_hovered", slot_index, false)
	
