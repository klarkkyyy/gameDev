extends Area2D

var collected: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player") or collected:
		return
	collected = true
	game_state.got_key()
	animation_player.play("pickupKey")
	await animation_player.animation_finished
	hide()

func reset():
	collected = false
	animation_player.stop()
	$AudioStreamPlayer2D.stop()
	show()
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("default")
	$CollisionShape2D.set_deferred("disabled", false)
	monitoring = true
