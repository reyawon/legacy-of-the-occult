extends Button

@onready var tech_tree_ui_scene = preload("res://scenes/tech_tree/tech_tree_ui.tscn")

func _pressed() -> void:
	print('pressed')
	var tech_ui = tech_tree_ui_scene.instantiate()
	add_child(tech_ui)
