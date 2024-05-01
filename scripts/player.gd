extends CharacterBody2D

const SPEED = 120
var player_state = "idle"
var player_is_attacking = false
signal player_attacking

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.x == 0 && direction.y == 0:
		player_state = "idle"
		if Input.is_action_just_pressed("attack"):
			player_is_attacking = true
			await get_tree().create_timer(1 - 4 * 1/10).timeout
			player_is_attacking = false
	else:
		player_state = "walking"
	velocity = direction * SPEED
	move_and_slide()
	play_animation(direction, player_state, player_is_attacking)

func play_animation(direction: Vector2, player_state: String, player_is_attacking: bool):
	if player_state == "idle":
		if player_is_attacking:
			$AnimatedSprite2D.play("attacking")
			await get_tree().create_timer(1 - 4 * 1/10).timeout
			player_attacking.emit()
			print("hit !")
		else:
			$AnimatedSprite2D.play("idle")
	if player_state == "walking":
		$AnimatedSprite2D.play("walking")
