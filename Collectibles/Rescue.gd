extends "res://Collectibles/Collectible.gd"

func _ready():
	if Game.rescue_list.has(get_parent().name + name):
		queue_free()
	else:
		visible = true

func _on_Collectible_body_entered(body):
	if body.name == "Player":
		get_parent().rescues_collected.append(get_parent().name + name)
		Game.play_sfx(load("res://Audio/Pickup.wav"))
		queue_free()