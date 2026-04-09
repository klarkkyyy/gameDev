extends Control

@onready var coin: Control = $VBoxContainer/HBoxContainer/Coin
@onready var coin_2: Control = $VBoxContainer/HBoxContainer/Coin2
@onready var coin_3: Control = $VBoxContainer/HBoxContainer/Coin3
@onready var key: Control = $VBoxContainer/Key
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var h_box_container: HBoxContainer = $VBoxContainer/HBoxContainer

func _ready():
	game_state.hud = self
	v_box_container.hide()
	h_box_container.hide()
	coin.hide()
	coin_2.hide()
	coin_3.hide()
	key.hide()

func reset_hud():
	coin.hide()
	coin_2.hide()
	coin_3.hide()
	key.hide()
	h_box_container.hide()
	v_box_container.hide()

func show_coin1():
	if not h_box_container.visible:
		h_box_container.show()
	v_box_container.show()
	coin.show()

func show_coin2():
	if not h_box_container.visible:
		h_box_container.show()
	v_box_container.show()
	coin_2.show()

func show_coin3():
	if not h_box_container.visible:
		h_box_container.show()
	v_box_container.show()
	coin_3.show()

func show_key():
	v_box_container.show()
	key.show()
