extends PhantomCamera2D

var is_dragging := false
var drag_start_pos := Vector2()
@onready var map_limit_target: CollisionShape2D = get_node("/root/world/MapDelimiter")

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
		apply_camera_limits()

func apply_camera_limits():
	var shape = map_limit_target.shape
	if shape is RectangleShape2D:
		var min_x = map_limit_target.global_position.x - shape.extents.x
		var max_x = map_limit_target.global_position.x + shape.extents.x
		var min_y = map_limit_target.global_position.y - shape.extents.y
		var max_y = map_limit_target.global_position.y + shape.extents.y
		
		position.x = clamp(position.x, min_x, max_x)
		position.y = clamp(position.y, min_y, max_y)
