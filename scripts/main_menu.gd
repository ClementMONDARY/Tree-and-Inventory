extends Control

signal game_started
signal menu_opened
var is_game_started = false

func _ready():
	pass

func _on_play_button_pressed():
	%AnimationPlayer.play("zoom_in")
	end_music($main_music)
	$Buttons_VBoxContainer/AnimationPlayer.play("fade_out")
	await get_tree().create_timer($Buttons_VBoxContainer/AnimationPlayer.get_animation("fade_out").get_length()).timeout
	$Buttons_VBoxContainer.visible = false
	is_game_started = true
	game_started.emit()

func _on_settings_button_pressed():
	pass # Replace with function body.

func _on_exit_button_pressed():
	$Buttons_VBoxContainer/ExitGame.play()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape") && is_game_started == true:
		is_game_started = false
		menu_opened.emit()
		$Buttons_VBoxContainer/AnimationPlayer.play("fade_in")
		%AnimationPlayer.play("zoom_out")
		$Buttons_VBoxContainer.visible = true
		await get_tree().create_timer($Buttons_VBoxContainer/AnimationPlayer.get_animation("fade_in").get_length()).timeout

func end_music(music: AudioStreamPlayer) -> void:
	var anim_player = music.get_node("AnimationPlayer")
	anim_player.play("fade_in")
	await get_tree().create_timer(anim_player.get_animation("fade_in").get_length()).timeout
	music.stream_paused = true

# Sounds

func _on_play_button_mouse_entered() -> void:
	$Buttons_VBoxContainer/Hover_Buttons.play()

func _on_settings_button_mouse_entered() -> void:
	$Buttons_VBoxContainer/Hover_Buttons.play()

func _on_exit_button_mouse_entered() -> void:
	$Buttons_VBoxContainer/Hover_Buttons.play()
