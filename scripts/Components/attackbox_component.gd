extends Area2D

@export var attack_component: AttackComponent

func _ready() -> void:
	monitoring = false

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		area.damage(attack_component.attack)
