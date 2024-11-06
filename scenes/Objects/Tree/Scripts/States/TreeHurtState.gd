extends State
class_name TreeHurt

@export var animation_manager: AnimationManager
@export var particules_player: CPUParticles2D

func _ready() -> void:
	if !animation_manager or !particules_player:
		printerr("TreeIdle: Missing required components.")
		return
	
	animation_manager.animated_sprite.animation_finished.connect(_on_animation_finished)

func Enter() -> void:
	animation_manager.play("hurt")
	particules_player.emitting = true

func _on_animation_finished() -> void:
	Transitioned.emit(self, "Idle")
