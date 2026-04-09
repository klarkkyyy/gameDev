extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 8.0
const font_size = 70
const GRAVITY = 9.8

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label

var is_invincible: bool = false
var _blink_tween: Tween = null
var label_timer: float = 8.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")

	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	velocity.z = 0  # lock Z so player can't move into/out of screen
	move_and_slide()

func start_invincibility(duration: float = 2.0):
	is_invincible = true
	_start_blink()
	await get_tree().create_timer(duration).timeout
	is_invincible = false
	if _blink_tween:
		_blink_tween.kill()
	animated_sprite_2d.modulate.a = 1.0

func _start_blink():
	if _blink_tween:
		_blink_tween.kill()
	_blink_tween = create_tween()
	_blink_tween.set_loops()
	_blink_tween.tween_property(animated_sprite_2d, "modulate:a", 0.2, 0.15)
	_blink_tween.tween_property(animated_sprite_2d, "modulate:a", 1.0, 0.15)
