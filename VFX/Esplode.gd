extends Node2D


func _ready():
	$AnimationPlayer.connect("animation_finished", self, "_on_anim_finished")
	$AnimationPlayer.play("esplode")
	
func _on_anim_finished():
	queue_free()
