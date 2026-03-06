extends Area2D

@onready var open: Sprite2D = $open
@onready var close: Sprite2D = $close
@onready var area: Area2D = $Area2D

var door_opened = false
var key_obtained = false
var player_inside = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_state.door = self
	close.show()
	open.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if player_inside == false:
			player_inside = true
			print("around door")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		if player_inside == true:
			player_inside = false
			print("exited door")

func obtained_key():
	key_obtained = true
	
func _process(delta):
	if player_inside == true && key_obtained == true && door_opened == false && Input.is_action_just_pressed("interact"):
		close.hide()
		open.show()
		door_opened = true
		print("Door Opened!")
	elif player_inside == true && key_obtained == false && Input.is_action_just_pressed("interact"):
		print("Door doesn't budge... No key")
	
	elif door_opened == true && Input.is_action_just_pressed("interact"):
		print("Onto the next level!")
		game_state.next_level()
