extends PhantomCamera2D

var is_dragging := false
var drag_start_pos := Vector2()

@onready var player = get_node("/root/world/game_nodes/player")
@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D
@onready var pointer_icon := $Path2D/PathFollow2D/Pointer

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_dragging = true
			drag_start_pos = event.position
		else:
			is_dragging = false
	elif event is InputEventMouseMotion and is_dragging:
		var delta_motion = (event.position - drag_start_pos) / zoom
		position -= delta_motion
		drag_start_pos = event.position

func _process(delta: float) -> void:
	update_pointer_icon()

func update_pointer_icon():
	var screen_size = get_viewport_rect().size / 2
	var relative_position = to_local(player.global_position)

	if abs(relative_position.x) > screen_size.x or abs(relative_position.y) > screen_size.y:
		path_follow.visible = true
		var angle = global_position.angle_to_point(player.global_position)
		var progress_ratio = (angle + PI) / TAU
		path_follow.progress_ratio = progress_ratio
		pointer_icon.rotation = angle + 3 * PI / 4
	else:
		path_follow.visible = false
