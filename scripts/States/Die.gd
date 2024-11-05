extends State
class_name DieState

@export var entity: AnimatedSprite2D

func Enter() -> void:
	if !entity.sprite_frames.get_animation_names().has("die"):
		return
	
	entity.play("die")
