extends AnimatableBody2D

@export var speed := 100.0
@export var distance := 200.0

var start_position
var direction := 1

func _ready():
	start_position = global_position

func _physics_process(delta):
	position.x += speed * direction * delta
	
	if abs(global_position.x - start_position.x) > distance:
		direction *= -1
