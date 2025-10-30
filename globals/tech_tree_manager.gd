extends Node

signal tech_unlocked(id: String)

@export var tree: TechTree
var researched:= {}

func _ready() -> void:
	tree._build_cache()
	tree._validate_acyclical()
	
func is_researched(id: String) -> bool:
	return researched.has(id)
	
func can_research(id: String) -> bool:
	if researched:
		return false
		
	var prereqs := tree.get_prereqs(id)
	for prereq in prereqs:
		if !is_researched(id):
			return false
	
	return true
	
func research(id: String) -> bool:
	if !can_research(id):
		return false
		
	researched[id] = true
	emit_signal("tech_unlocked", true)
	return true
