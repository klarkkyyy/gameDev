extends Camera3D

@export var target: Node3D
@export var min_y = -55.0
@export var max_y = 50.0
const CAMERA_SPEED = 5.0

func _process(delta):
	if target:
		var target_pos = Vector3(
			target.global_position.x,
			target.global_position.y + 2,
			8
		)
		global_position = global_position.lerp(target_pos, CAMERA_SPEED * delta)
		global_position.y = clamp(global_position.y, min_y, max_y)
