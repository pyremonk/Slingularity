extends Node2D

export var num_jumps = 3 # Max number of launches a player has for the level
export var darkness = false
export var darkness_rate = 50
export var darkness_max_x = 750
export(Array) var start_dialogue
export(AudioStream) var bgm

var cur_dialogue_line = 0
var dialogue_done = false
var next_level = "BaseLevel"
var rescues_collected = []


func _ready():
	Physics2DServer.area_set_param(get_world_2d().space,Physics2DServer.AREA_PARAM_GRAVITY_VECTOR,Vector2(0,0))
	Game.is_game_over = false
	Game.message_label = $HUD/Message
	$Player.jumps_available = num_jumps
	if Game.find_node("bgm_player").stream != bgm:
		Game.find_node("bgm_player").stream = bgm
		Game.find_node("bgm_player").play()

func _process(delta):
	$HUD/JumpLabel/JumpCount.text = str($Player.jumps_available)
	$HUD/RescueLabel/RescueCount.text = str(Game.num_rescues)