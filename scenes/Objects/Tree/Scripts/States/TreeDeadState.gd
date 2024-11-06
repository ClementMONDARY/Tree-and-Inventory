extends State
class_name TreeDie

@export var animation_manager: AnimationManager
@export var particules_player: CPUParticles2D
@export var growth_timer: Timer
@export var wood_marker: Marker2D
@export var health_component: HealthComponent
var wood = preload("res://scenes/Objects/Wood/wood_collectible.tscn")

func _ready() -> void:
	if !animation_manager or !particules_player or !growth_timer or !wood_marker:
		printerr("TreeDie: Missing required components.")
		return
	
	growth_timer.timeout.connect(_on_growth_timer_timeout)

func Enter() -> void:
	call_deferred("_deferred_enter")

func _deferred_enter() -> void:
	animation_manager.play("die")
	particules_player.emitting = true
	
	var wood_instance = wood.instantiate()
	wood_instance.global_position = wood_marker.global_position
	get_tree().current_scene.add_child(wood_instance)
	wood_instance.tree_exited.connect(_on_tree_exited)

func _on_tree_exited() -> void:
	print("growth_timer started")
	growth_timer.start()

func _on_growth_timer_timeout() -> void:
	health_component.set_max_health()
	Transitioned.emit(self, "Idle")
