extends PhantomCamera2D

var is_dragging := false
var drag_start_pos := Vector2()

@onready var player = get_node("/root/world/game_nodes/player")

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
