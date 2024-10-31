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
	var screen_size = get_viewport_rect().size / 2  # Demi-tailles de l'écran pour le centrage
	var relative_position = to_local(player.global_position)
	
	if abs(relative_position.x) > screen_size.x or abs(relative_position.y) > screen_size.y:
		path_follow.visible = true
		
		# Calcul de l'angle pour pointer vers le joueur
		var angle = global_position.angle_to_point(player.global_position)
		
		# Conversion de l'angle en position sur les bords du rectangle de l'écran
		var max_x = screen_size.x * cos(angle)
		var max_y = screen_size.y * sin(angle)
		
		# Ajustement pour que l'icône se place sur les bords de l'écran
		if abs(max_x) > screen_size.x:
			max_x = sign(max_x) * screen_size.x
		if abs(max_y) > screen_size.y:
			max_y = sign(max_y) * screen_size.y
		
		# Positionnement de l'icône en fonction des coordonnées calculées
		path_follow.offset = Vector2(max_x, max_y).length()
		pointer_icon.rotation = angle
	else:
		path_follow.visible = false
