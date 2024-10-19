extends Control

signal game_started

func _ready():
	$Blackscreen/AnimationPlayer.play("fade_out")

func _on_play_button_pressed():
	%AnimationPlayer.play("zoom_in")
	$Buttons_VBoxContainer/AnimationPlayer.play("fade_out")
	await get_tree().create_timer($Buttons_VBoxContainer/AnimationPlayer.get_animation("fade_out").get_length()).timeout
	$Buttons_VBoxContainer.visible = false
	game_started.emit()

func _on_settings_button_pressed():
	pass # Replace with function body.

func _on_exit_button_pressed():
	$Blackscreen/AnimationPlayer.play("fade_in")
	await get_tree().create_timer($Blackscreen/AnimationPlayer.get_animation("fade_in").get_length()).timeout
	get_tree().quit()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		$Buttons_VBoxContainer/AnimationPlayer.play("fade_in")
		%AnimationPlayer.play("zoom_out")
		$Buttons_VBoxContainer.visible = true
		await get_tree().create_timer($Buttons_VBoxContainer/AnimationPlayer.get_animation("fade_in").get_length()).timeout
		
