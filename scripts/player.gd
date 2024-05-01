extends CharacterBody2D

const SPEED = 120
var player_state = "idle"
var player_is_attacking = false
var attack_cooldown = false
signal player_attacking

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.x == 0 && direction.y == 0:
		player_state = "idle"
		if Input.is_action_just_pressed("attack") && !player_is_attacking && !attack_cooldown:
			player_is_attacking = true
			$AnimatedSprite2D.play("attacking")
			attack_cooldown = true
			await get_tree().create_timer(1 - 0.7).timeout
			player_attacking.emit()
			print("hit !")
			await get_tree().create_timer(1 - 0.7).timeout
			player_is_attacking = false
			attack_cooldown = false
			$AnimatedSprite2D.play("idle")
	else:
		player_state = "walking"
	velocity = direction * SPEED
	play_animation(direction, player_state)
	if !player_is_attacking:
		move_and_slide()

func play_animation(direction: Vector2, player_state: String):
	if player_state == "idle":
		if !player_is_attacking:
			$AnimatedSprite2D.play("idle")
	elif player_state == "walking" && !player_is_attacking:
		$AnimatedSprite2D.play("walking")
	
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction.x > 0:
		$AnimatedSprite2D.flip_h = false
