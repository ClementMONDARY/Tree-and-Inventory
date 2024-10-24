extends Camera2D

enum MenuAction {
	Open,
	Close,
}

const ATTACHED_ZOOM = Vector2(2, 2)
const DETACHED_ZOOM = Vector2(1.75, 1.75)

var is_game_started: bool
var is_camera_detached: bool

func _ready() -> void:
	set_zoom(Vector2(1.5, 1.5))
	$Blackscreen/AnimationPlayer.play("fade_out")
	is_game_started = false
	is_camera_detached = false

func _on_exit_button_pressed() -> void:
	$Blackscreen/AnimationPlayer.play("fade_in")
	await get_tree().create_timer($Blackscreen/AnimationPlayer.get_animation("fade_in").get_length()).timeout
	get_tree().quit()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("detach") && is_game_started:
		match is_camera_detached:
			true:
				attach_anim()
			false:
				detach_anim()
	if Input.is_action_just_pressed("escape") && is_game_started:
		menu_anim(MenuAction.Open)

func change_camera_mode():
	match is_camera_detached:
		true:
			attach_anim()
		false:
			detach_anim()

func menu_anim(action: MenuAction):
	match action:
		MenuAction.Open:
			open_menu_anim()
		MenuAction.Close:
			close_menu_anim()

func open_menu_anim():
	$AnimationPlayer.get_animation("open_menu").track_set_key_value(0, 0, zoom)
	$AnimationPlayer.play("open_menu")
	is_game_started = false

func close_menu_anim():
	$AnimationPlayer.get_animation("close_menu").track_set_key_value(0, 0, zoom)
	match is_camera_detached:
		true:
			$AnimationPlayer.get_animation("close_menu").track_set_key_value(0, 1, DETACHED_ZOOM)
		false:
			$AnimationPlayer.get_animation("close_menu").track_set_key_value(0, 1, ATTACHED_ZOOM)
	print($AnimationPlayer.get_animation("close_menu").track_get_key_value(0, 0))
	print($AnimationPlayer.get_animation("close_menu").track_get_key_value(0, 1))
	$AnimationPlayer.play("close_menu")
	is_game_started = true

func attach_anim():
	$AnimationPlayer.play("attach_to_player_zoom")
	$camera_zoom_in.play()
	await get_tree().create_timer($AnimationPlayer.get_animation("attach_to_player_zoom").get_length()).timeout
	is_camera_detached = false

func detach_anim():
	$AnimationPlayer.play("detach_from_player_zoom")
	$camera_zoom_out.play()
	await get_tree().create_timer($AnimationPlayer.get_animation("detach_from_player_zoom").get_length()).timeout
	is_camera_detached = true

func _on_play_button_pressed() -> void:
	if !is_game_started:
		menu_anim(MenuAction.Close)
