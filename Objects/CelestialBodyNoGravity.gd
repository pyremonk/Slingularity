extends StaticBody2D

export var orbit_direction = "clockwise" # Or "counterclockwise"
export var orbit_speed = 1

func _process(delta):
	if orbit_direction == "clockwise":
		rotate(orbit_speed * delta)
	elif orbit_direction == "counterclockwise":
		rotate(orbit_speed * delta * -1)


func _on_CollisionArea_body_entered(body):
	if body.name == "Player":
		$"../Player".esplode()
		Game.game_over()