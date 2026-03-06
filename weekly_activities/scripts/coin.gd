extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var coin = $Sprite2D


func _on_body_entered(body: Node2D) -> void:
	game_state.add_coin()
	animation_player.play("pickup")
