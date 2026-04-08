extends Area2D

var collected: bool = false

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player") or collected:
		return
	collected = true
	game_state.add_coin()
	$AnimationPlayer.play("pickup")
	await $AnimationPlayer.animation_finished
	hide()

func reset():
	collected = false
	$AnimationPlayer.stop()
	$PickupSound.stop()
	show()
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("default")
	$CollisionShape2D.set_deferred("disabled", false)
	monitoring = true
