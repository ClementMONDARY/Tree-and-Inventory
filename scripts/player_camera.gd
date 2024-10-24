extends Camera2D

var is_game_started = false
var is_camera_detached = false

func _ready() -> void:
	set_zoom(Vector2(1.5, 1.5))
	$Blackscreen/AnimationPlayer.play("fade_out")

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
		open_menu()

func change_camera_mode():
	match is_camera_detached:
		true:
			attach_anim()
		false:
			detach_anim()

func open_menu():
	$AnimationPlayer.get_animation("open_menu").track_set_key_value(0, 0, zoom)
	$AnimationPlayer.play("open_menu")
	is_game_started = false

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
		match is_camera_detached:
			true:
				$AnimationPlayer.play("zoom_in_detached")
				await get_tree().create_timer($AnimationPlayer.get_animation("zoom_in_detached").get_length()).timeout
				is_game_started = true
			false:
				$AnimationPlayer.play("zoom_in_attached")
				await get_tree().create_timer($AnimationPlayer.get_animation("zoom_in_attached").get_length()).timeout
				is_game_started = true
