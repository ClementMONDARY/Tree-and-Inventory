extends Area2D
class_name HurtboxComponent

@export var health_component: HealthComponent
signal is_hurt

func damage(attack_damage: int) -> void:
	if attack_damage > 0.0 && health_component.current_health > 0.0:
		health_component.current_health -= attack_damage
		is_hurt.emit()
	
	if health_component.current_health <= 0.0 and get_parent().is_in_group("killable"):
		get_parent().queue_free()
