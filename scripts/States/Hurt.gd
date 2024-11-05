extends State
class_name HurtState

@export var entity: AnimatedSprite2D
@export var health_component: HealthComponent

func Enter() -> void:
	if !entity.sprite_frames.get_animation_names().has("hurt"):
		return
	
	if health_component.health > 0:
		entity.play("hurt")
	else:
		Transitioned.emit(self, "Die")
