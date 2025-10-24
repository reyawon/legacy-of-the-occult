extends CharacterBody2D

@export var walk_speed: int = 350
@export var sprint_speed: int = 500
@onready var sprite: AnimatedSprite2D = $PlayerSprite
@export var inventory: Inventory
var current_direction:= "_south_cardinal"
var sprinting := true
var current_stamina:= 100

func _physics_process(_delta: float) -> void:
	var input := Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		
	if Input.is_action_pressed("sprint") and _can_sprint():
		sprinting = true
	else:
		sprinting = false
		
	var speed:= sprint_speed if sprinting else walk_speed
	
	if input != Vector2.ZERO:
		input = input.normalized()
		velocity = input * speed
		move_and_slide()
		_play_animation(_update_prefix_animation(), input)
	else:
		velocity = Vector2.ZERO
		_play_animation("idle", input)
		move_and_slide()
		
		
func _can_sprint() -> bool:
	return current_stamina > 1
	
func _update_prefix_animation() -> String:
	if sprinting:
		return "run"
	else:
		return "walk"
		
func _play_animation(prefix: String, dir: Vector2) -> void:
	var flip := false
	
	var animation_name := prefix + _dir_to_suffix(dir)
	if animation_name.ends_with(",FLIP"):
		flip = true
		animation_name = animation_name.substr(0, animation_name.length() - ",FLIP".length())
		
	if sprite.animation != animation_name:
		sprite.play(animation_name)
		
	if flip == true:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
func _dir_to_suffix(dir: Vector2) -> String:
	if dir == Vector2.ZERO:
		return current_direction
		
	var angle := rad_to_deg(atan2(dir.y, dir.x))
	angle = fmod(angle + 360.0, 360.0)
	
	if angle < 22.5 or angle >= 337.5:
		current_direction = "_lateral_cardinal,FLIP"
		return "_lateral_cardinal,FLIP"
	elif angle < 67.5:
		current_direction = "_south_intercardinal,FLIP"
		return "_south_intercardinal,FLIP"
	elif angle < 112.5:
		current_direction = "_south_cardinal"
		return "_south_cardinal"
	elif angle < 157.5:
		current_direction = "_south_intercardinal"
		return "_south_intercardinal"
	elif angle < 202.5:
		current_direction = "_lateral_cardinal"
		return "_lateral_cardinal"
	elif angle < 247.5:
		current_direction = "_north_intercardinal"
		return "_north_intercardinal"
	elif angle < 292.5:
		current_direction = "_north_cardinal"
		return "_north_cardinal"
	else:
		current_direction = "_north_intercardinal,FLIP"
		return "_north_intercardinal,FLIP"
		
		
	
