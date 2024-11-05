extends Node

var is_game_started = false
var is_camera_detached = false

@onready var freecam: PhantomCamera2D = $FreeCam
@onready var playercam: PhantomCamera2D = $PlayerCam
@onready var menucam: PhantomCamera2D = $MenuCam
@onready var zoom_in_sound: AudioStreamPlayer = $camera_zoom_in
@onready var zoom_out_sound: AudioStreamPlayer = $camera_zoom_out
@onready var blackscreen_anim: AnimationPlayer = menucam.get_node("AnimationPlayer")
@onready var menu_tween_duration: float = 2.00
@onready var freecam_tween_duration: float = 0.5

func _ready() -> void:
	$MenuCam/BlackScreen.visible = true
	blackscreen_anim.play("fade_out")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape") && is_game_started:
		is_game_started = false
		open_menu()
	if Input.is_action_just_pressed("detach") && is_game_started:
		change_camera_mode()

func change_camera_mode():
	reset_priorities()
	match is_camera_detached:
		true:
			zoom_in_sound.play()
			playercam.tween_duration = freecam_tween_duration
			playercam.priority = 1
			is_camera_detached = false
		false:
			zoom_out_sound.play()
			freecam.tween_duration = freecam_tween_duration
			freecam.position = playercam.position
			freecam.priority = 1
			is_camera_detached = true

func open_menu():
	reset_priorities()
	menucam.position = freecam.position if is_camera_detached else playercam.position
	menucam.priority = 1

func reset_priorities():
	var camera_list = [freecam, playercam, menucam]
	for camera in camera_list:
		if camera != null:
			camera.priority = 0

func _on_play_button_pressed() -> void:
	reset_priorities()
	
	var active_cam = freecam if is_camera_detached else playercam
	active_cam.tween_duration = menu_tween_duration
	active_cam.priority = 1
	
	is_game_started = true


func _on_exit_button_pressed() -> void:
	blackscreen_anim.get_animation("fade_in").track_set_key_value(0, 0, $MenuCam/BlackScreen.modulate)
	blackscreen_anim.play("fade_in")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		get_tree().quit()
