extends State
class_name TreeIdle

@export var animation_manager: AnimationManager
@export var health_component: HealthComponent
@export var hurtbox_component: HurtboxComponent

func _ready() -> void:
	if !animation_manager or !health_component or !hurtbox_component:
		push_error("IdleState: Missing required components.")
		return
	
	hurtbox_component.is_hurt.connect(_on_tree_hurt)

func Enter() -> void:
	if health_component.current_health < health_component.max_health:
		animation_manager.play("idle")

func _on_tree_hurt() -> void:
	if health_component.current_health > 0:
		Transitioned.emit(self, "Hurt")
	else:
		animation_manager.play_audio("hurt")
		Transitioned.emit(self, "Dead")
