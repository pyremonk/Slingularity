extends Control


func _process(delta):
	
	if Game.level_success:
		$Success.visible = true
		$Button.visible = false
	
		if get_parent().rescues_collected.size() > 0:
			$Success/RescueMessage.visible = true
	
	if Game.is_game_over:
		$GameOver.visible = true
		$Button.visible = false

	if get_parent().start_dialogue.size() > 0 && get_parent().cur_dialogue_line+1 <= get_parent().start_dialogue.size() && !get_parent().dialogue_done:
		$LevelDialogue.visible = true
		$LevelDialogue/Message.text = get_parent().start_dialogue[get_parent().cur_dialogue_line]
	else:
		get_parent().dialogue_done = true
		get_parent().cur_dialogue_line = 0
		$LevelDialogue.visible = false
		$LevelDialogue/Message.text = ""

func _on_Button_pressed():
	Game.play_button_pressed_sfx()
	Game.reset_level()


func _on_Retry_pressed():
	Game.play_button_pressed_sfx()
	Game.reset_level()


func _on_MainMenu_pressed():
	Game.play_button_pressed_sfx()
	Game.return_to_main()


func _on_NextLevel_pressed():
	Game.play_button_pressed_sfx()
	Game.goto_level(get_parent().next_level)

func _on_NextLine_pressed():
	Game.play_button_pressed_sfx()
	get_parent().cur_dialogue_line += 1
