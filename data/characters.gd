class_name CharacterTable
extends RefCounted


# --- Column Arrays --- 
var ids: PackedInt32Array = PackedInt32Array()
var hp: PackedFloat32Array = PackedFloat32Array()
var con_stat: PackedInt32Array = PackedInt32Array()
var dex_stat: PackedInt32Array = PackedInt32Array()
var int_stat: PackedInt32Array = PackedInt32Array()
var str_stat: PackedInt32Array = PackedInt32Array()
var wis_stat: PackedInt32Array = PackedInt32Array()

# --- Indexing ---
var _index_to_id: PackedInt32Array = PackedInt32Array()
var _id_to_index: Dictionary = {}
var _next_id := 1

# --- Helpers ---
func count() -> int:
	return _index_to_id.size()
	
func has(id) -> bool:
	return _id_to_index.has(id)

# --- Create ---
func create(
	hp0: float, 
	con0: int, 
	dex0: int, 
	int0: int, 
	str0: int, 
	wis0: int) -> int:
		
	var id:= _next_id
	_next_id += 1
	var i = count()
	
	# grows column arrays by 1
	ids.push_back(id)
	hp.push_back(hp0)
	con_stat.push_back(con0)
	dex_stat.push_back(dex0)
	int_stat.push_back(int0)
	str_stat.push_back(str0)
	wis_stat.push_back(wis0)
	
	_index_to_id.push_back(id)
	_id_to_index[id] = i
	return id
	
# --- Delete ---
func delete(id: int) -> void:
	if not _id_to_index.has(id):
		return
		
	var i: int = _id_to_index[id]
	var last := count() -1
	
	# moves the last row into position i for every column
	if i != last:
		ids[i] = ids[last]
		hp[i] = hp[last]
		con_stat[i] = con_stat[last]
		dex_stat[i] = con_stat[last]
		int_stat[i] = int_stat[last]
		str_stat[i] = int_stat[last]
		wis_stat[i] = wis_stat[last]
		
		var moved_id := _index_to_id[last]
		_index_to_id[i] = moved_id
		_id_to_index[moved_id] = i
	
	#pops the last element from every column
	ids.resize(last)
	hp.resize(last)
	con_stat.resize(last)
	dex_stat.resize(last)
	int_stat.resize(last)
	str_stat.resize(last)
	wis_stat.resize(last)
	_index_to_id.resize(last)
	
	_id_to_index.erase(id)
	
	
	
	
