extends RigidBody2D

onready var esplode_scene = preload("res://VFX/Esplode.tscn")
onready var jump_scene = preload("res://VFX/JumpFX.tscn")

export var impulse_factor = 2

var draw_launch_preview = false
var full_stop = false
var mouse_start_position = Vector2()
var jumps_available
var aiming = false

signal full_stop
signal launch

func _ready():
	$Line2D.add_point(Vector2(0,0))
	$Line2D.add_point(Vector2(0,0))
	$"../JumpPoint".connect("player_entered", self, "_on_player_entered")

func _process(delta):
	
	if draw_launch_preview:
		var new_point_position = mouse_start_position - get_global_mouse_position()
		$Line2D.set_point_position(1, -new_point_position)
		$Line2D.visible = true
		$Sprite.rotation = $Sprite.position.angle_to_point($Line2D.get_point_position(1))
	else:
		$Line2D.visible = false	
	

func _physics_process(delta):
	if Input.is_action_pressed("launch") && !Game.is_game_over && !Game.level_success && get_parent().dialogue_done && !aiming:
		if jumps_available > 0:
			if mouse_start_position == Vector2(0,0):
				mouse_start_position = get_global_mouse_position()
			_full_stop(true)
			aiming = true

	if full_stop:
		set_linear_velocity(Vector2(0,0))

	if Input.is_action_just_released("launch") && !Game.is_game_over && !Game.level_success && get_parent().dialogue_done && aiming:
		if jumps_available > 0:
			jumps_available -= 1

		var impulse_distance = $Line2D.get_point_position(0).distance_to($Line2D.get_point_position(1))
		
		if impulse_distance > 0:
			_launch()
		


func _launch():
	full_stop = false
	aiming = false
	draw_launch_preview = false
	Game.play_sfx(load("res://Audio/Launch3.wav"))
	apply_central_impulse(($Line2D.get_point_position(0)-$Line2D.get_point_position(1))*impulse_factor)
	emit_signal("launch")


func _full_stop(launch_preview = false):
	full_stop = true
	draw_launch_preview = launch_preview
	emit_signal("full_stop")


func _on_player_entered():
	jump()
	

func _on_VisibilityNotifier2D_screen_exited():
	_full_stop()
	Game.game_over()

func esplode():
	_full_stop()
	visible = false
	var explosion = esplode_scene.instance()
	explosion.position = position
	get_parent().find_node("VFX").add_child(explosion)
	Game.play_sfx(load("res://Audio/Explosion38.wav"))
	
func jump():
	_full_stop()
	visible = false
	var jump_fx = jump_scene.instance()
	jump_fx.position = position
	get_parent().find_node("VFX").add_child(jump_fx)
	Game.play_sfx(load("res://Audio/Jump.wav"))
