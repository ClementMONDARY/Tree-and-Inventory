extends Node2D

var is_game_launched = false

func _on_play_button_pressed() -> void:
	if !is_game_launched:
		is_game_launched = true
		init_music($biome_music)

func init_music(music: AudioStreamPlayer) -> void:
	var anim_player = music.get_node("AnimationPlayer")
	music.play()
	anim_player.play("fade_out")
