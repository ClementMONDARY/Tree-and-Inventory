extends State
class_name IdleState

@export var entity: AnimatedSprite2D
@export var health_component: HealthComponent

var max_health: float

func _ready() -> void:
	max_health = health_component.health

func Enter() -> void:
	if !entity.sprite_frames.get_animation_names().has("idle"):
		return
	
	if health_component.health >= 3:
		entity.play("idle")
		entity.frame = randi_range(0, entity.sprite_frames.get_frame_count("idle") - 1)
