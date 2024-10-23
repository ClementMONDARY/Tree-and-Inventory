extends Control

signal game_started
signal menu_opened

var is_game_started = false
var buttons_container: VBoxContainer = null
var fade_in_anim: Animation = null
var fade_out_anim: Animation = null
var hover_sound: AudioStreamPlayer = null

func _ready():
	buttons_container = get_node("Buttons_VBoxContainer")
	fade_in_anim = buttons_container.AnimationPlayer.get_animation("fade_in")
	fade_out_anim = buttons_container.AnimationPlayer.get_animation("fade_out")
	hover_sound = get_node("Buttons_VBoxContainer/Hover_Buttons")

func _on_play_button_pressed():
	buttons_container.AnimationPlayer.play(fade_out_anim)
	await(fade_out_anim.get_length())
	buttons_container.visible = false
	is_game_started = true
	game_started.emit()

func _on_settings_button_pressed():
	pass

func _on_exit_button_pressed():
	buttons_container.ExitGame.play()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape") && is_game_started:
		is_game_started = false
		menu_opened.emit()
		buttons_container.AnimationPlayer.play(fade_in_anim)
		buttons_container.visible = true
		await(fade_in_anim.get_length())

# Removed unnecessary end_music function

func _on_play_button_mouse_entered():
	hover_sound.play()

func _on_settings_button_mouse_entered():
	hover_sound.play()

func _on_exit_button_mouse_entered():
	hover_sound.play()
