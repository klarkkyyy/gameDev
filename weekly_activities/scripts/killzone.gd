extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not body.is_invincible:
		print("You Died!!!")
		game_state.add_death()
		game_state.reset_run()
		_reset_collectibles()
		var spawn = get_tree().get_first_node_in_group("spawn_point")
		body.global_position = spawn.global_position
		body.velocity = Vector2.ZERO
		body.start_invincibility(2.0)

func _reset_collectibles():
	print("Resetting collectibles...")
	for coin in get_tree().get_nodes_in_group("coin"):
		print("Resetting coin: ", coin.name)
		coin.reset()
	for key in get_tree().get_nodes_in_group("key"):
		key.reset()
	for bee in get_tree().get_nodes_in_group("bee"):
		bee.reset_state()
