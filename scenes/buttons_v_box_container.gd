extends VBoxContainer

enum MenuAction {
	Open,
	Close,
}

var menu_anim: AnimationPlayer

func _ready() -> void:
	visible = true
	menu_anim = $AnimationPlayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		open_menu()

func open_menu():
	menu_anim.get_animation("fade_in").track_set_key_value(0, 0, modulate)
	menu_anim.play("fade_in")

func close_menu():
	menu_anim.get_animation("fade_out").track_set_key_value(0, 0, modulate)
	menu_anim.play("fade_out")

# Signals ------------------------------------------------------------------------------------------

func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		visible = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		visible = false

func _on_play_button_pressed() -> void:
	close_menu()

func _on_play_button_mouse_entered() -> void:
	$Hover_Buttons.play()

func _on_settings_button_mouse_entered() -> void:
	$Hover_Buttons.play()

func _on_exit_button_mouse_entered() -> void:
	$Hover_Buttons.play()
