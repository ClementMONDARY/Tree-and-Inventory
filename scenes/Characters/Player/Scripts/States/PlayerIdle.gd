extends State
class_name PlayerIdle

@export var animation_manager: AnimationManager
var can_move: bool = false

func Enter() -> void:
	animation_manager.play("idle")

func Update(delta: float) -> void:
	

#Pour le fonctionnement avec le menu:
	#- Je fais une variable global dans State qui indique si le joueur peut bouger ? (plutôt celle-ci)
	#- Je fais un state spécifique pour quand le menu est ouvert ?
