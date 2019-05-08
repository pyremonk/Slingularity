extends Node2D


func _on_TextureButton_pressed():
	Game.play_button_pressed_sfx()
	get_tree().change_scene("res://Levels/Level1.tscn")

func _on_pyremonk_90_pressed():
	OS.shell_open("https://pyremonk.itch.io")
