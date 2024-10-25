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

#region Private Functions

func _ready() -> void:
	pass

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
	
