extends State
class_name PlayerMenuOpened

@export var animation_manager: AnimationManager

func Enter() -> void:
	animation_manager.play("idle")

func _on_play_button_pressed() -> void:
	Transitioned.emit(self, "Idle")
