extends Camera2D

func _ready() -> void:
	set_zoom(Vector2(1.5, 1.5))

func _process(delta: float) -> void:
	print(zoom)
