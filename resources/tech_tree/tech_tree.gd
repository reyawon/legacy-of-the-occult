extends Resource
class_name TechTree

@export var techs: Array[Tech] = []

var _by_id: Dictionary = {} #lookup id -> tech
var _dependents: Dictionary = {} #reverse adjacency list


func _init() -> void:
	_by_id = {}
	_dependents = {}
	
func _build_cache() -> void:
	"""Maps techs dictionary and builds reverse adjacency list"""
	_by_id.clear()
	_dependents.clear()
	
	#maps each tech id to corresponding tech resource
	for tech in techs:
		_by_id[tech.id] = tech
		
	#builds reverse adjacency list
	for tech in techs:
		for prereq in tech.prereqs:
			if prereq not in _dependents:
				_dependents[prereq] = []
			_dependents[prereq].append(tech.id)
			
func get_tech(id: String) -> Tech:
	"""Returns the technology resource"""
	return _by_id.get(id)
	
func get_prereqs(id: String) -> Array[String]:
	"""Returns a list of immediate technology prerequisites"""
	var tech = get_tech(id)
	if tech:
		return tech.prereqs
	else:
		return []
	
func get_dependents(id: String) -> Array[String]:
	"""Returns a reverse adjacency list of the argument technology id"""
	return _dependents[id].get(id, [])
	
func _validate_acyclical() -> bool:
	"""DFS cycle detection algorithm. Validates that the graph is acyclical."""
	var visiting := {}
	var visited := {}
	
	for tech in techs:
		if !_visit(tech.id, visiting, visited):
			push_error("Cycle found. Tech tree is not acyclical: " + tech.id)
			return false
	return true

func _visit(id: String, visiting: Dictionary, visited: Dictionary) -> bool:
	"""This function is called resursively on on each tech resource's prereqs """
	if id in visited:
		return true
	if id in visiting:
		return false
	
	visiting[id] = true
	for prereq in get_prereqs(id):
		if !_visit(prereq, visiting, visited):
			return false
	
	visiting.erase(id)
	visited[id] = true
	return true

		
		
	
