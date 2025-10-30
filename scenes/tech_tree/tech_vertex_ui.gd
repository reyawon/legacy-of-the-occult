extends Button
class_name TechVertexUI

var id: String
const BASE_STYLEBOX := preload("res://scenes/tech_tree/tech_vertex_stylebox_normal.tres")
const HOVER_STYLEBOX := preload("res://scenes/tech_tree/tech_vertex_stylebox_hover.tres")

const BASE_LOCKED_STYLEBOX := preload("res://scenes/tech_tree/tech_vertex_locked_stylebox_normal.tres")

const FANTASY_FONT := preload("res://assets/fonts/old-fantasy/Old-fantasyupper-case.ttf")

func _ready() -> void:
	add_theme_font_override('font', FANTASY_FONT)
	add_theme_color_override('font_color', Color.BLACK)
	

func update_visual():
	"""Updates the visuals of a vertex depending on its state."""
	var ttmgr := TechTreeManager
	
	if ttmgr.is_researched(id):
		text = 'UNLOCKED\n' + ttmgr.tree.get_tech(id).display_name
		disabled = true
		modulate = Color(0.0, 0.329, 0.048, 1.0)
	elif ttmgr.can_research(id):
		text = 'READY\n' + ttmgr.tree.get_tech(id).display_name
		disabled = false
		add_theme_stylebox_override('normal', BASE_STYLEBOX)
		add_theme_stylebox_override('hover', HOVER_STYLEBOX)
	else:
		text = 'LOCKED\n' + ttmgr.tree.get_tech(id).display_name
		add_theme_stylebox_override('disabled', BASE_LOCKED_STYLEBOX)
		disabled = true
		
		
func _on_pressed() -> void:
	var ttmgr := TechTreeManager
	if ttmgr.can_research(id):
		print('refresh all')
		get_parent().get_parent().refresh_all()
		
