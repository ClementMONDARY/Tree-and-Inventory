extends Area2D
class_name HurtboxComponent

@export var health_component: HealthComponent

func damage(attack_damage: int) -> void:
	if attack_damage > 0.0 && health_component.health > 0.0:
		health_component.health -= attack_damage
	
	if health_component.health <= 0.0 and get_parent().is_in_group("killable"):
		get_parent().queue_free()
