extends State
class_name WoodIdle

@export var animation_manager: AnimationManager
@export var pickbox: PickboxComponent

func Enter() -> void:
	animation_manager.play("idle")
