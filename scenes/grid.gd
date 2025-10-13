extends TileMapLayer

func _ready() -> void:
	var filled_tiles := get_used_cells()
	for grid_tile: Vector2i in filled_tiles:
		var neighboring_tiles := get_surrounding_cells(grid_tile)
		for neighbor: Vector2i in neighboring_tiles:
			if get_cell_source_id(neighbor) == -1:
				set_cell(neighbor, 2, Vector2.ZERO)
		
