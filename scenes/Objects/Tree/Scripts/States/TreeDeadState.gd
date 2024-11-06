extends State
class_name TreeDie

@export var entity: AnimatedSprite2D
@export var particules_player: CPUParticles2D
@export var growth_timer: Timer
@export var wood_marker: Marker2D
@export var health_component: HealthComponent
var wood = preload("res://scenes/Objects/Wood/wood_collectible.tscn")

func _ready() -> void:
	if !entity or !particules_player or !growth_timer or !wood_marker:
		printerr("TreeDie: Missing required components.")
		return
	
	if !entity.sprite_frames.get_animation_names().has("die"):
		printerr("The AnimatedSprite " + entity.name + " do not contains the \"die\" animation.")
		return
	
	growth_timer.timeout.connect(on_growth_timer_timeout)

func Enter() -> void:
	entity.play("die")
	particules_player.emitting = true
	
	# Instancie le nœud "wood_collectible" et l'ajoute en tant qu'enfant du nœud parent
	var wood_instance = wood.instantiate()
	wood_instance.global_position = wood_marker.global_position
	get_tree().current_scene.add_child(wood_instance)
	
	# Connecte le signal "tree_exited" du nœud "wood_collectible"
	wood_instance.tree_exited.connect(_on_tree_exited)

func _on_tree_exited() -> void:
	print("growth_timer started")
	growth_timer.start()

func on_growth_timer_timeout() -> void:
	health_component.set_max_health()
	Transitioned.emit(self, "Idle")
