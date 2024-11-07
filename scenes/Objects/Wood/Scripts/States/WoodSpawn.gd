extends State
class_name WoodSpawn

@export var animation_manager: AnimationManager

func Enter() -> void:
	animation_manager.animated_sprite.animation_finished.connect(_on_spawn_animation_finished)
	animation_manager.play("spawn")

func _on_spawn_animation_finished() -> void:
	Transitioned.emit(self, "Idle")
