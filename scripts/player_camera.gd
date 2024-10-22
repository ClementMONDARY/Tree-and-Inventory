extends Camera2D

func _ready() -> void:
	set_zoom(Vector2(1.5, 1.5))
	$Blackscreen/AnimationPlayer.play("fade_out")

func _on_exit_button_pressed() -> void:
	$Blackscreen/AnimationPlayer.play("fade_in")
	await get_tree().create_timer($Blackscreen/AnimationPlayer.get_animation("fade_in").get_length()).timeout
	get_tree().quit()
