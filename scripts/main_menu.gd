extends Control

signal game_started
signal menu_opened
var is_game_started = false

func _ready():
	pass

func _on_play_button_pressed():
	end_music($main_music)
	is_game_started = true
	game_started.emit()

func _on_settings_button_pressed():
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape") && is_game_started:
		is_game_started = false
		menu_opened.emit()

func end_music(music: AudioStreamPlayer) -> void:
	var anim_player = music.get_node("AnimationPlayer")
	anim_player.play("fade_in")
	await get_tree().create_timer(anim_player.get_animation("fade_in").get_length()).timeout
	music.stream_paused = true

# signals ------------------------------------------------------------------------------------------
