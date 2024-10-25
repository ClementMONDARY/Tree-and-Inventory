extends Camera2D

enum MenuAction {
	Open,
	Close,
}

const ATTACHED_ZOOM = Vector2(2, 2)
const DETACHED_ZOOM = Vector2(1.75, 1.75)

var is_game_started: bool
var is_camera_detached: bool
var camera_anim: AnimationPlayer

func _ready() -> void:
	set_zoom(Vector2(1.5, 1.5))
	camera_anim = $AnimationPlayer
	is_game_started = false
	is_camera_detached = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("detach") && is_game_started:
		change_camera_mode()
	if Input.is_action_just_pressed("escape") && is_game_started:
		menu_anim(MenuAction.Open)

# change_camera_mode -------------------------------------------------------------------------------

func change_camera_mode():
	match is_camera_detached:
		true:
			attach_anim()
		false:
			detach_anim()

func attach_anim():
	camera_anim.get_animation("attach_to_player_zoom").track_set_key_value(0, 0, zoom)
	camera_anim.play("attach_to_player_zoom")
	$camera_zoom_in.play()
	is_camera_detached = false

func detach_anim():
	camera_anim.get_animation("detach_from_player_zoom").track_set_key_value(0, 0, zoom)
	camera_anim.play("detach_from_player_zoom")
	$camera_zoom_out.play()
	is_camera_detached = true

# menu_anim ----------------------------------------------------------------------------------------

func menu_anim(action: MenuAction):
	match action:
		MenuAction.Open:
			open_menu_anim()
		MenuAction.Close:
			close_menu_anim()

func open_menu_anim():
	camera_anim.get_animation("open_menu").track_set_key_value(0, 0, zoom)
	camera_anim.play("open_menu")
	is_game_started = false

func close_menu_anim():
	camera_anim.get_animation("close_menu").track_set_key_value(0, 0, zoom)
	match is_camera_detached:
		true:
			camera_anim.get_animation("close_menu").track_set_key_value(0, 1, DETACHED_ZOOM)
		false:
			camera_anim.get_animation("close_menu").track_set_key_value(0, 1, ATTACHED_ZOOM)
	camera_anim.play("close_menu")
	is_game_started = true

# signals ------------------------------------------------------------------------------------------

func _on_play_button_pressed() -> void:
	if !is_game_started:
		menu_anim(MenuAction.Close)
