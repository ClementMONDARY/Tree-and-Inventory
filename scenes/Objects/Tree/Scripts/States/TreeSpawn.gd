extends State
class_name TreeSpawn

@export var health: HealthComponent
@export var animation_manager: AnimationManager

func Enter() -> void:
	health.set_max_health()
	animation_manager.play_random_frame("idle")
	await get_tree().create_timer(0.1).timeout
	call_deferred("emit_transition")

func emit_transition() -> void:
	Transitioned.emit(self, "Idle")
