extends State
class_name TreeHurt

@export var entity: AnimatedSprite2D
@export var particules_player: CPUParticles2D
@export var hurt_effect: AnimationPlayer

func _ready() -> void:
	if !entity or !particules_player or !hurt_effect:
		printerr("TreeIdle: Missing required components.")
		return
	
	if !entity.sprite_frames.get_animation_names().has("hurt") and !hurt_effect.get_animation("hurt"):
		printerr("The AnimatedSprite " + entity.name + " do not contains the \"hurt\" animation.")
		return
		
	entity.animation_finished.connect(hurt_animation_finished)

func Enter() -> void:
	entity.play("hurt")
	hurt_effect.play("hurt")
	particules_player.emitting = true

func hurt_animation_finished() -> void:
	Transitioned.emit(self, "Idle")
