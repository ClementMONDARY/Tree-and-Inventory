extends Node

#region Enum

#region Const

#region Variables

var is_game_started = false
var is_camera_detached = false

@onready var freecam: PhantomCamera2D = $FreeCam
@onready var playercam: PhantomCamera2D = $PlayerCam
@onready var menucam: PhantomCamera2D = $MenuCam
@onready var blackscreen_anim: AnimationPlayer = $MenuCam/AnimationPlayer
@onready var playercam_tween_duration: float = playercam.tween_duration

#region Private Functions

func _ready() -> void:
	$MenuCam/BlackScreen.visible = true
	blackscreen_anim.play("fade_out")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape") && is_game_started:
		is_game_started = false
		close_menu()
	if Input.is_action_just_pressed("detach") && is_game_started:
		print("swap_cam")
		change_camera_mode()

func change_camera_mode():
	reset_priorities()
	match is_camera_detached:
		true:
			playercam.set_priority(1)
			is_camera_detached = false
		false:
			freecam.position = playercam.position
			freecam.set_priority(1)
			is_camera_detached = true

func close_menu():
	reset_priorities()
	menucam.set_priority(1)

func reset_priorities():
	var camera_list = [freecam, playercam, menucam]
	for camera in camera_list:
		if camera != null:
			camera.set_priority(0)

func _on_play_button_pressed() -> void:
	reset_priorities()
	match is_camera_detached:
		true:
			freecam.position = playercam.position
			freecam.set_priority(1)
		false:
			playercam.set_priority(1)
	is_game_started = true

func _on_exit_button_pressed() -> void:
	blackscreen_anim.get_animation("fade_in").track_set_key_value(0, 0, $MenuCam/BlackScreen.modulate)
	blackscreen_anim.play("fade_in")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		get_tree().quit()
