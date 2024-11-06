extends CharacterBody2D

enum player_state_enum { IDLE, WALKING }

const SPEED = 120
const SLIDE_FACTOR = 0.75
const FOOTSTEP_INTERVAL = 0.2

var player_state := player_state_enum.IDLE
var player_is_attacking := false
var player_can_move := false
var footstep_timer := 0.0

@onready var footstep_particles = $CPUParticles2D

@export_group("Player Stats")
@export var health_component: HealthComponent
@export var attack_component: AttackComponent

func _physics_process(delta):
	if player_can_move:
		var direction = Input.get_vector("left", "right", "up", "down")
		if direction.x == 0 && direction.y == 0:
			player_state = player_state_enum.IDLE
			footstep_timer = 0.0
		else:
			player_state = player_state_enum.WALKING
			if player_state == player_state_enum.WALKING:
				footstep_timer += delta
				if footstep_timer >= FOOTSTEP_INTERVAL:
					emit_footstep(direction)
					footstep_timer = 0.0
		
		if Input.is_action_pressed("attack") && !player_is_attacking:
			attack()
		else:
			if direction.x == 0 && direction.y == 0:
				velocity *= SLIDE_FACTOR
			else:
				velocity = direction * SPEED
			
			if !player_is_attacking:
				play_animation(direction, player_state)
				move_and_slide()
		
		if Input.is_action_just_pressed("escape"):
			velocity = Vector2(0, 0)
			$AnimatedSprite2D.play("idle")
			player_can_move = false
		

func emit_footstep(direction: Vector2):
	var emission_direction = -direction.normalized()
	footstep_particles.position = emission_direction * 10
	footstep_particles.direction = emission_direction
	footstep_particles.restart()
	footstep_particles.emitting = true

func attack():
	player_is_attacking = true
	$AnimatedSprite2D.play("attacking")
	await get_tree().create_timer(0.3).timeout
	$AttackboxComponent.monitoring = true
	await get_tree().create_timer(0.3).timeout
	$AttackboxComponent.monitoring = false
	player_is_attacking = false
	$AnimatedSprite2D.play("idle")

func play_animation(direction: Vector2, current_player_state: player_state_enum):
	if current_player_state == player_state_enum.IDLE:
		if !player_is_attacking:
			$AnimatedSprite2D.play("idle")
	elif current_player_state == player_state_enum.WALKING:
		$AnimatedSprite2D.play("walking")
	
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
		$AttackboxComponent.scale.x = -1
	elif direction.x > 0:
		$AnimatedSprite2D.flip_h = false
		$AttackboxComponent.scale.x = 1

func _on_play_button_pressed() -> void:
	player_can_move = true
