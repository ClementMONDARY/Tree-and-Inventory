extends Control

signal game_started
signal menu_opened
var is_game_started = false

func _ready():
	visible = true

func _on_settings_button_pressed():
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape") && is_game_started:
		is_game_started = false
		menu_opened.emit()

func end_main_music() -> void:
	$main_music/AnimationPlayer.get_animation("fade_in").track_set_key_value(0, 0, $main_music.volume_db)
	$main_music/AnimationPlayer.play("fade_in")

# signals ------------------------------------------------------------------------------------------

func _on_play_button_pressed():
	end_main_music()
	is_game_started = true
	game_started.emit()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		$main_music.stop()
