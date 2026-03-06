extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -270.0
const font_size = 70




@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label



var label_timer: float = 8.0
var tip_indx: int = 0
var tip_indx2: int = 0

var tips = [
		["I wonder what
		would happen if i
		touch that slime", #[0][0]
		"Do you think by getting
		a key we can
		unlock the door ? ! 😱", #[0][1]
		
		"What are the coins for?
		Exactly. For Nothing.", #[0][2]
		
		"I think if you fall
		down you'll die...
		idk tho"], #[0][3]
		
		["Hmm... I think E or S or ↓
		was the button for Interact", #[1][0]
		"Imagine getting
		hit by an arrow"] #[1][1]
]

func _ready():
	label.modulate.a = 0
	label.add_theme_font_size_override("font_size", font_size)
	await get_tree().create_timer(5.0).timeout
	show_next_tip()
	

func show_next_tip():
	show_tip(tips[game_state.tip_indx][game_state.tip_indx2], 6.5)
	game_state.tip_indx2 += 1
	if game_state.tip_indx2 >= tips[game_state.tip_indx].size():
		game_state.tip_indx2 = 0
		game_state.tip_indx = (game_state.tip_indx + 1) % tips.size()

func show_tip(text: String = "", duration: float = 6.0):
	if text == "":
		text = tips[tip_indx][tip_indx2]
	label.text = text
	label.show()
	label_timer = duration
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 1.0, 1.5)

func _process(delta):
	if label_timer > 0:
		label_timer -= delta
		if label_timer <= 0:
			fade_out_tip()

func fade_out_tip():
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 0.0, 1.5)
	await tween.finished
	label.hide()
	await get_tree().create_timer(6.5).timeout 
	show_next_tip()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed(" jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
		
	# Play animations
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

	move_and_slide()
