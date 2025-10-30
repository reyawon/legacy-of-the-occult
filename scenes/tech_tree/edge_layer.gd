extends Control

func _draw() -> void:
	"""Draws a line from the right side to the left side of each vertex"""
	var ttmgr:= TechTreeManager
	var tree:= ttmgr.tree
	
	var ui := get_parent() as TechTreeUI
	
	for tech_id in tree._by_id.keys():
		var prereqs = tree.get_prereqs(tech_id)
		for prereq_id in prereqs:
			var from_vertex := ui.get_vertex(prereq_id)
			var to_vertex := ui.get_vertex(tech_id)
			if from_vertex == null or to_vertex == null:
				continue
				
			#calculates drawing positions from vertex position and size
			var from_pos := from_vertex.position
			var to_pos := to_vertex.position
			var from_size := from_vertex.size
			var to_size := to_vertex.size
			
			var from_point := from_pos + Vector2(from_size.x, from_size.y * 0.5)
			var to_point := to_pos + Vector2(0.0, to_size.y * 0.5)
			
			draw_line(from_point, to_point, Color.WHITE, 5.0)
