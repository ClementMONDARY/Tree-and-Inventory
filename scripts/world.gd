extends Node2D

var is_game_launched = false

@onready var ambiance: AudioStreamPlayer = $biome_ambience
@onready var music: AudioStreamPlayer = $biome_music

var ambiance_anim: AnimationPlayer
var music_anim: AnimationPlayer

func _ready() -> void:
	ambiance_anim = ambiance.get_node("AnimationPlayer")
	music_anim = music.get_node("AnimationPlayer")

func _on_play_button_pressed() -> void:
	if !is_game_launched:
		is_game_launched = true
		init_music()

func init_music() -> void:
	music.play()
	music_anim.play("fade_out")


func _on_exit_button_pressed() -> void:
	music_anim.get_animation("fade_in").track_set_key_value(0, 0, music.volume_db)
	music_anim.play("fade_in")
	ambiance_anim.play("fade_in")
