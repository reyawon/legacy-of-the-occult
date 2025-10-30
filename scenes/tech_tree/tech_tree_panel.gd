extends PanelContainer

var is_open := false

func _ready() -> void:
	_close()

func _process(_delta: float) -> void:
	"""Opens and closes the technology panel depending on current state."""
	if Input.is_action_just_pressed("open_tech_tree"):
		if is_open:
			_close()
		else:
			_open()
		
func _open() -> void:
	"""Opens technology panel."""
	visible = true
	is_open = true
	
func _close() -> void:
	"""Closes technology panel."""
	visible = false
	is_open = false
