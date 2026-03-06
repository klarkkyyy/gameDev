extends Area2D



func _on_body_entered(body: Node2D) -> void:
	print("You Died!!!")
	game_state._ready()
	get_tree().reload_current_scene()
