extends CharacterBody2D

@export var speed: int = 500
@onready var sprite: AnimatedSprite2D = $PlayerSprite


func _physics_process(delta: float) -> void:
	var input := Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)
	
	if input != Vector2.ZERO:
		input = input.normalized()
		velocity = input * speed
		move_and_slide()
		_play_animation("walk", input)
	else:
		velocity = Vector2.ZERO
		move_and_slide()
		
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
		return "_south_cardinal"
		
	var angle := rad_to_deg(atan2(dir.y, dir.x))
	angle = fmod(angle + 360.0, 360.0)
	
	if angle < 22.5 or angle >= 337.5:
		return "_lateral_cardinal,FLIP"
	elif angle < 67.5:
		return "_south_intercardinal,FLIP"
	elif angle < 112.5:
		return "_south_cardinal"
	elif angle < 157.5:
		return "_south_intercardinal"
	elif angle < 202.5:
		return "_lateral_cardinal"
	elif angle < 247.5:
		return "_north_intercardinal"
	elif angle < 292.5:
		return "_north_cardinal"
	else:
		return "_north_intercardinal,FLIP"
		
		
	
