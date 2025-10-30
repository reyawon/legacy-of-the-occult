extends Control
class_name TechTreeUI

var ttmgr: TechTreeManager
@export var vertex_position: Dictionary = {
	#tier 1
	'mana_channel': Vector2(100,200),
	'runic_crafting': Vector2(100,400),
	'arcane_literature': Vector2(100,600),
	#tier 2
	'leyline_engineering': Vector2(450,200),
	'advanced_runesmithing': Vector2(450,400),
	'elemental_attunement': Vector2(450,600),
	#tier 3
	'arcane_reactors': Vector2(900,200),
	'sentient_construction': Vector2(900,400),
	'elemental_domination': Vector2(900,600),
	#tier 4
	'aetheric_synthesis': Vector2(1400,400)
}

@onready var vertex_layer = $VertexLayer
@onready var edge_layer = $EdgeLayer

func _ready() -> void:
	ttmgr = TechTreeManager
	build_vertices()
	refresh_all()
	TechTreeManager.tech_unlocked.connect(_on_tech_unlocked)
	
func build_vertices() -> void:
	"""Builds the technology vertices and assigns corresponding property values."""
	queue_free_children(vertex_layer)
	for tech_id in ttmgr.tree._by_id.keys():
		var vertex_ui := TechVertexUI.new()
		vertex_ui.id = tech_id
		vertex_ui.text = tech_id
		vertex_ui.custom_minimum_size = Vector2(200,60)
		vertex_ui.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		vertex_ui.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		vertex_ui.position.round()
		vertex_layer.add_child(vertex_ui)
		vertex_ui.position = vertex_position.get(tech_id, Vector2.ZERO)
		
		vertex_ui.pressed.connect(vertex_ui._on_pressed)
		
func refresh_all() -> void:
	"""Refreshes visuals for each vertex."""
	for vertex_ui in vertex_layer.get_children():
		vertex_ui.update_visual()
		
	edge_layer.queue_redraw()
	
func _on_tech_unlocked(_id: String) -> void:
	"""Called on a technology being unlocked to refresh visuals"""
	refresh_all()
	
func get_vertex(tech_id: String) -> Control:
	"""Returns vertex button node"""
	for vertex_ui in vertex_layer.get_children():
		if vertex_ui.id == tech_id:
			return vertex_ui
	return null
	
func queue_free_children(node: Node) -> void:
	"""Helper function to delete all children."""
	for child in node.get_children():
		child.queue_free()

	
