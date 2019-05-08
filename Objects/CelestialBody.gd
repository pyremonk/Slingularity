extends StaticBody2D

export var gravity_strength = 300
export(Texture) var override_texture
export var rotate_direction = "clockwise" # Or "counterclockwise"
export var rotate_speed = 0.5


func _ready():
	$GravityField.gravity = gravity_strength
	$"../Player".connect("full_stop", self, "_on_Player_full_stop")
	$"../Player".connect("launch", self, "_on_Player_launch")
	$Sprite.texture = override_texture
	randomize()
	var rotate_direction_rand = rand_range(0, 100)
	
	if rotate_direction_rand < 50:
		rotate_direction = "counterclockwise"
		
	rotate_speed = rand_range(0, 1)


func _process(delta):
	if rotate_direction == "clockwise":
		$Sprite.rotate(rotate_speed * delta)
	elif rotate_direction == "counterclockwise":
		$Sprite.rotate(rotate_speed * delta * -1)

func _on_CollisionArea_body_entered(body):
	if body.name == "Player":
		$"../Player".esplode()
		Game.game_over()


func _on_Player_full_stop():
	$GravityField.gravity = 0
	$GravityField.gravity_point = false
	

func _on_Player_launch():
	$GravityField.gravity = gravity_strength
	$GravityField.gravity_point = true