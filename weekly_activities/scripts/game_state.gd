extends Node

var point: int = 0
var level: int = 1
var deaths: int = 0
var key: int = 0
var hud = null
var door = null
var tip_indx: int = 0
var tip_indx2: int = 0

func _ready() -> void:
	point = 0
	deaths = 0
	key = 0

func add_coin():
	point += 1
	if point == 1:
		hud.show_coin1()
	elif point == 2:
		hud.show_coin2()
	elif point == 3:
		hud.show_coin3()
	print(point)
	
func next_level():
	level += 1
	if level == 2:
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")

func add_death():
	deaths += 1
	print(deaths)
	
func got_key():
	key += 1
	hud.show_key()
	door.obtained_key()
	print("Key Obtained!")
	
	
