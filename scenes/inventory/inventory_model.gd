extends PanelContainer
class_name InventoryModel

signal update_item

@export var inventory: Inventory
@export var inventory_background_texture: Texture2D
@export var columns: int
@export var background_theme: StyleBox
@onready var inventory_grid: GridContainer = $InventoryGrid
var slots: Dictionary


var is_open = false

func _ready() -> void:
	close()
	if background_theme:
		background_theme.resource_local_to_scene = true
		add_theme_stylebox_override("panel", background_theme)
		
	_build_slots()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("open_inventory"):
		if is_open:
			close()
		else:
			open()
			
			
func _build_slots() -> void:
	var slot_scene = preload("res://scenes/inventory/inventory_slot_ui.tscn")
	var slot_num = 0
	
	inventory_grid.columns = columns
	
	for i in range(inventory.items.size()):
		var slot: InventorySlotUI = slot_scene.instantiate()
		var inv_item = inventory.items[i]
		
		slot.name = "slot_%d" % slot_num
		slot.slot_index = slot_num
		slot.item = inv_item
		
		slot.slot_hovered.connect(_on_slot_hovered)
		update_item.connect(slot.on_update_item)
		inventory_grid.add_child(slot)
		slots[slot.name] = slot
		slot_num+= 1
	
	print(slots)
		
func _on_slot_hovered(_slot_index: int, _entered: bool) -> void:
	pass
		
func move_item(origin_slot: int, destination_slot: int) -> void:
	var origin_name = "slot_%d" % origin_slot
	var destination_name = "slot_%d" % destination_slot
	
	slots[destination_name].item = slots[origin_name].item
	slots[origin_name].item = null
	slots[origin_name].occupied = false
	slots[destination_name].occupied = true
	
	update_item.emit()
	
func open() -> void:
	visible = true
	is_open = true
	
func close() -> void:
	visible = false
	is_open = false
	

	
