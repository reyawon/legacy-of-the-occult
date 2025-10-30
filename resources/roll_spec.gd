class_name RollSpec
extends Resource

enum ValueType {INT, FLOAT}
enum Mode {FIXED, RANGE, DICE}

@export var value_type: ValueType = ValueType.INT 
@export var mode: Mode = Mode.FIXED

#FIXED
@export var fixed_value: float = 0.0

#RANGE
@export var min_value: float = 0.0
@export var max_value: float = 0.0

#DICE
@export var dice_count: int = 1
@export var dice_sides	: int = 6
@export var dice_mod: int = 0

func sample(seed_: int) -> float:
	var rng = RandomNumberGenerator.new()
	rng.seed = int(seed_)
	
	var result:= 0.0
	match mode:
		Mode.FIXED:
			result = fixed_value
		Mode.RANGE:
			result = rng.randf_range(min_value, max_value)
		Mode.DICE:
			var total:= 0
			for i in dice_count:
				total += rng.randi_range(1, dice_sides)
			result += (total + dice_mod)
	
	if value_type == ValueType.INT:
		result = float(int(round(result)))
		
	return result
			
			
	
	
