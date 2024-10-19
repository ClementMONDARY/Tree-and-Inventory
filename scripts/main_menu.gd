extends Control

var is_game_started = false

func _ready():
	$Blackscreen/AnimationPlayer.play("fade_out")

func _on_play_button_pressed():
	%AnimationPlayer.play("zoom_in")
	is_game_started = true

func _on_settings_button_pressed():
	pass # Replace with function body.

func _on_exit_button_pressed():
	var animation_length = $Blackscreen/AnimationPlayer.get_animation("fade_in").get_length()
	var fade_n_zoom_length_difference = %AnimationPlayer.get_animation("zoom_out").get_length() - animation_length
	if is_game_started:
		%AnimationPlayer.play("zoom_out")
		await get_tree().create_timer(fade_n_zoom_length_difference).timeout
	
	$Blackscreen/AnimationPlayer.play("fade_in")
	await get_tree().create_timer(animation_length).timeout
	get_tree().quit()
