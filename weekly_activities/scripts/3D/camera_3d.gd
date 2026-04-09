extends Camera3D

@export var target: Node3D
const CAMERA_SPEED = 5.0

func _process(delta):
	if target:
		var target_pos = Vector3(
			target.global_position.x,
			target.global_position.y + 2,
			15
		)
		global_position = global_position.lerp(target_pos, CAMERA_SPEED * delta)
