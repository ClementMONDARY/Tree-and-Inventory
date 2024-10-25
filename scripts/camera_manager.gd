extends Node

#region Enum

enum Camera {
	Free = 0,
	Player = 1,
	Menu = 2,
}

#region Const



#region Variables

var is_game_started = false
var is_camera_detached = false
var current_camera: Camera = Camera.Menu

@onready var freecam: PhantomCamera2D = $FreeCam
@onready var playercam: PhantomCamera2D = $PlayerCam
@onready var menucam: PhantomCamera2D = $MenuCam
@onready var blackscreen_anim: AnimationPlayer = $MenuCam/AnimationPlayer

#region Private Functions

func _ready() -> void:
	blackscreen_anim.play("fade_out")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape") && is_game_started:
		is_game_started = false
		close_menu()

func close_menu():
	reset_priorities()
	menucam.priority = 1

func reset_priorities():
	var camera_list = [freecam, playercam, menucam]
	for camera in camera_list:
		if camera != null:
			camera.priority = 0

func _on_play_button_pressed() -> void:
	reset_priorities()
	playercam.priority = 1
	is_game_started = true

func _on_exit_button_pressed() -> void:
	blackscreen_anim.get_animation("fade_in").track_set_key_value(0, 0, $MenuCam/BlackScreen.modulate)
	blackscreen_anim.play("fade_in")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		get_tree().quit()
