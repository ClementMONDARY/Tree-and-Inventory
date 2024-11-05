extends Panel

func _ready() -> void:
	visible = true
	$AnimationPlayer.play("fade_out")

func _on_exit_button_pressed() -> void:
	$AnimationPlayer.play("fade_in")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		get_tree().quit()
