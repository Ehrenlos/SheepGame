extends KinematicBody2D
class_name Entity

export (int) var GRAVITY := 20
export (int) var ACCELERATION := 50
export (int) var MAX_SPEED := 200
export (int) var JUMP_HEIGHT = 360

var motion = Vector2()
var friction := false


func _physics_process(_delta: float) -> void:
	motion.y += GRAVITY
	motion  = move_and_slide(motion, Vector2.UP, false, 4, PI/4, false)

func _apply_friction() -> Vector2:
	if is_on_floor():
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
	return motion

func apply_movement(direction: Vector2) -> Vector2:
	friction = (direction.x == 0)
	motion.x += ACCELERATION * direction.x
	if direction.x == 1:
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	elif direction.x == -1:
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, 0.2)
	
	motion = _apply_friction()
	if direction.y == -1:
			motion.y = -JUMP_HEIGHT
	return motion
	
