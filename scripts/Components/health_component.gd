extends Node2D
class_name HealthComponent

@export var max_health: float = 1.0
var current_health: float

func _ready() -> void:
	set_max_health()

func set_max_health() -> void:
	current_health = max_health
