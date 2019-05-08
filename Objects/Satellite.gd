extends Node2D

export var offset = 75
export var orbit_direction = "clockwise" # Or "counterclockwise"
export var orbit_speed = 1
export(Texture) var override_texture


func _ready():
	$Body.position.x = offset
	$Body/Sprite.texture = override_texture

func _process(delta):
	if orbit_direction == "clockwise":
		rotate(orbit_speed * delta)
	elif orbit_direction == "counterclockwise":
		rotate(orbit_speed * delta * -1)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$"../../Player".esplode()
		Game.game_over()
