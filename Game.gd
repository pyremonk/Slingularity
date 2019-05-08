extends Node

var current_level = "BaseLevel"
var levels_unlocked = {}
var is_game_over = false
var level_success = false
var message_label
var num_rescues = 0
var rescue_list = []

func _ready():
	_set_num_rescues()

func reset_level():
	get_tree().reload_current_scene()

func goto_level(level):
	level_success = false
	get_tree().change_scene("res://Levels/" + level + ".tscn")

func game_over():
	is_game_over = true
	
func return_to_main():
	is_game_over = false
	level_success = false
	num_rescues = 0
	rescue_list.clear()
	get_tree().change_scene("res://UI/MainMenu.tscn")

func add_rescue(unique_name):
	if !rescue_list.has(unique_name):
		rescue_list.append(unique_name)
	
	_set_num_rescues()
	
func _set_num_rescues():
	num_rescues = rescue_list.size()

func play_button_pressed_sfx():
	$sfx_player.stream = load("res://Audio/Blip_Select31.wav")
	$sfx_player.play()
	
func play_sfx(effect):
	$sfx_player.stream = effect
	$sfx_player.play()