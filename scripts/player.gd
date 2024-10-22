extends CharacterBody2D

const SPEED = 120
const SLIDE_FACTOR = 0.75
var player_state = "idle"
var player_is_attacking = false
var player_can_move = false
signal player_attacking

func _on_main_menu_game_started():
	player_can_move = true

func _on_main_menu_menu_opened() -> void:
	player_can_move = false

func _physics_process(delta):
	if player_can_move:
		var direction = Input.get_vector("left", "right", "up", "down")
		if direction.x == 0 && direction.y == 0:
			player_state = "idle"
		else:
			player_state = "walking"
		
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

func attack():
	player_is_attacking = true
	$AnimatedSprite2D.play("attacking")
	await get_tree().create_timer(0.3).timeout
	player_attacking.emit()
	print("hit !")
	await get_tree().create_timer(0.3).timeout
	player_is_attacking = false
	$AnimatedSprite2D.play("idle")

func play_animation(direction: Vector2, current_player_state: String):
	if current_player_state == "idle":
		if !player_is_attacking:
			$AnimatedSprite2D.play("idle")
	elif current_player_state == "walking":
		$AnimatedSprite2D.play("walking")
	
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction.x > 0:
		$AnimatedSprite2D.flip_h = false
