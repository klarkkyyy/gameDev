extends Area2D

const CHASE_SPEED = 25.0
const RETURN_SPEED = 25.0
const LEASH_DISTANCE = 150.0
const GIVE_UP_DISTANCE = 150.0
const HOVER_AMPLITUDE = 4.0
const HOVER_SPEED = 2.0
const ATTACK_DISTANCE = 30.0 

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var detection_zone: Area2D = $DetectionZone

var spawn_position: Vector2
var player: Node2D = null
var state: String = "idle"
var hover_time: float = 0.0
var idle_anim_timer: float = 0.0
var idle_anim_phase: int = 0  

func _ready() -> void:
	spawn_position = global_position
	detection_zone.body_entered.connect(_on_detection_zone_body_entered)
	detection_zone.body_exited.connect(_on_detection_zone_body_exited)
	animated_sprite.play("idle")

func reset_state():
	player = null
	state = "return"


func _physics_process(delta: float) -> void:
	hover_time += delta

	match state:
		"idle":
			_hover_in_place(delta)
			_update_idle_animation(delta)

		"chase":
			if player == null:
				state = "return"
				return
			var dist_from_spawn = global_position.distance_to(spawn_position)
			var dist_to_player = global_position.distance_to(player.global_position)
			if dist_from_spawn >= LEASH_DISTANCE or dist_to_player >= GIVE_UP_DISTANCE:
				player = null
				state = "return"
				return
			_move_toward(player.global_position, CHASE_SPEED, delta)
			_face_target(player.global_position)
			if dist_to_player <= ATTACK_DISTANCE:
				if animated_sprite.animation != "attack":
					animated_sprite.play("attack")
			else:
				if animated_sprite.animation != "attack_ready":
					animated_sprite.play("attack_ready")

		"return":
			var dist_to_spawn = global_position.distance_to(spawn_position)
			if dist_to_spawn < 4.0:
				global_position = spawn_position
				state = "idle"
				return
			_move_toward(spawn_position, RETURN_SPEED, delta)
			_face_target(spawn_position)
			if animated_sprite.animation != "idle":
				animated_sprite.play("idle")

func _update_idle_animation(delta: float) -> void:
	idle_anim_timer -= delta
	if idle_anim_timer <= 0.0:
		if idle_anim_phase == 0:
			animated_sprite.play("idle")
			idle_anim_timer = 2.5
			idle_anim_phase = 1
		else:
			animated_sprite.play("chill_ready")
			idle_anim_timer = 2.0
			idle_anim_phase = 0

func _hover_in_place(delta: float) -> void:
	var hover_offset = sin(hover_time * HOVER_SPEED) * HOVER_AMPLITUDE
	global_position = spawn_position + Vector2(0, hover_offset)

func _move_toward(target: Vector2, speed: float, delta: float) -> void:
	var direction = (target - global_position).normalized()
	global_position += direction * speed * delta

func _face_target(target: Vector2) -> void:
	animated_sprite.flip_h = target.x < global_position.x

func _on_detection_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		state = "chase"

func _on_detection_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass
