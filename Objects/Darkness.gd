extends Node2D

func _process(delta):
	if get_parent().darkness == true && !Game.level_success && get_parent().dialogue_done:
		if position.x < get_parent().darkness_max_x:
			position.x += get_parent().darkness_rate * delta

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$"../Player".esplode()
		Game.game_over()
