extends Area2D

export var next_level = "BaseLevel"
signal player_entered

func _ready():
	get_parent().next_level = next_level

func _on_JumpPoint_body_entered(body):
	if body.name == "Player":
		emit_signal("player_entered")
		Game.level_success = true
		
		if get_parent().rescues_collected.size() > 0:
			for rescue in get_parent().rescues_collected.size():
				Game.add_rescue(get_parent().rescues_collected[rescue])
		