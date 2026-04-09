extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and not body.is_invincible:
		game_state.add_death()
		game_state.reset_run()
		var spawn = get_tree().get_first_node_in_group("spawn_point")
		body.global_position = spawn.global_position
		body.velocity = Vector3.ZERO
		body.start_invincibility(2.0)
