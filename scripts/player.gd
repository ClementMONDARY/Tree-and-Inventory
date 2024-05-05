extends CharacterBody2D

const SPEED = 120
var player_state = "idle"
var player_is_attacking = false
signal player_attacking

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.x == 0 && direction.y == 0:
		player_state = "idle"
	else:
		player_state = "walking"
	
	if Input.is_action_pressed("attack") && !player_is_attacking:
		attack()
	else:
		velocity = direction * SPEED
		if !player_is_attacking:
			play_animation(direction, player_state)
			move_and_slide()

func attack():
	player_is_attacking = true
	$AnimatedSprite2D.play("attacking")
	await get_tree().create_timer(0.3).timeout
	player_attacking.emit()
	print("hit !")
	await get_tree().create_timer(0.3).timeout
	player_is_attacking = false
	$AnimatedSprite2D.play("idle")

func play_animation(direction: Vector2, player_state: String):
	if player_state == "idle":
		if !player_is_attacking:
			$AnimatedSprite2D.play("idle")
	elif player_state == "walking":
		$AnimatedSprite2D.play("walking")
	
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction.x > 0:
		$AnimatedSprite2D.flip_h = false
