extends "res://Levels/BaseLevel.gd"

func _ready():
	$HUD/Button.visible = false
	$HUD/JumpLabel.visible = false
	$HUD/JumpLabel/JumpCount.visible = false

func _on_Button_pressed():
	get_tree().change_scene("res://UI/MainMenu.tscn")
