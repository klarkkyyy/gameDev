extends Area3D

func _ready():
	body_entered.connect(_on_body_entered)
	print("Killzone ready!")

func _on_body_entered(body: Node3D) -> void:
	print("Something entered killzone: ", body.name)
	if body.is_in_group("player"):
		var spawn = get_tree().get_first_node_in_group("spawn_point")
		if spawn:
			print("Respawning player!")
			body.global_position = spawn.global_position
			body.velocity = Vector3.ZERO
		else:
			print("No spawn point found!")
