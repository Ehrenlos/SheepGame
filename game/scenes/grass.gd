extends Area2D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("eat"):
		if get_overlapping_bodies():
			get_overlapping_bodies()[0].food += 1
			queue_free()
