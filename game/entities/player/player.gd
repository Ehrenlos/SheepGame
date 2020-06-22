extends Entity
class_name Player

var food = 0

func _physics_process(_delta: float) -> void:
	var direction = _get_direction()
# warning-ignore:return_value_discarded
	apply_movement(direction)
	_play_animation(direction)
	
	if Input.is_action_pressed("poop") and food > 0:
		_poop()

func _get_direction():
	var x = float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left"))
	var y = -1.0 if Input.is_action_pressed("jump") and is_on_floor() else 1.0
	return Vector2(x, y)

func _play_animation(direction):
	if direction.x == 1:
		$Sprite.flip_h = false
		$Sprite.play("walk")
	elif direction.x == -1:
		$Sprite.flip_h = true
		$Sprite.play("walk")
	else:
		$Sprite.play("idle")
	
	

func _poop():
	food -= 1
	var poo = preload("res://entities/poo/Poo.tscn").instance()
	poo.position = position
	poo.get_node("Sprite").flip_h = $Sprite.flip_h
	poo.get_node("CollisionShape2D").position.x = 6 if $Sprite.flip_h else -6
	get_parent().add_child(poo)
