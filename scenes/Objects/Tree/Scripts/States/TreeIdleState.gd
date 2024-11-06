extends State
class_name TreeIdle

@export var entity: AnimatedSprite2D
@export var health_component: HealthComponent
@export var hurtbox_component: HurtboxComponent
@export var hurt_sfx: AudioStreamPlayer2D
var max_health: float

func _ready() -> void:
	if !entity or !health_component or !hurtbox_component or !hurt_sfx:
		printerr("IdleState: Missing required components.")
		return
	
	if !entity.sprite_frames.get_animation_names().has("idle"):
		printerr("The AnimatedSprite " + entity.name + " do not contains the \"idle\" animation.")
		return
	
	entity.modulate = Color.WHITE
	max_health = health_component.current_health
	hurtbox_component.is_hurt.connect(_on_tree_hurt)

func Enter() -> void:
	entity.play("idle")
	if health_component.current_health == max_health:
		entity.frame = randi_range(0, entity.sprite_frames.get_frame_count("idle") - 1)

func _on_tree_hurt() -> void:
	hurt_sfx.play()
	if health_component.current_health > 0:
		Transitioned.emit(self, "Hurt")
	else:
		Transitioned.emit(self, "Dead")
