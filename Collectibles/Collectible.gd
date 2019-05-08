extends Area2D


func _on_Collectible_body_entered(body):
	if body.name == "Player":
		queue_free()
