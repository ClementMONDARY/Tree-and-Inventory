extends StaticBody2D

var tree_health = 3
var is_area_entered = false
var wood = preload("res://scenes/wood_collectible.tscn")

func _ready():
	$AnimatedSprite2D.frame = randi_range(0, $AnimatedSprite2D.sprite_frames.get_frame_count("idle") - 1)

func _on_chop_area_body_entered(body):
	if body.name == "player":
		is_area_entered = true

func _on_chop_area_body_exited(body):
	if body.name == "player":
		is_area_entered = false

func _on_player_player_attacking():
	if is_area_entered and tree_health > 0:
		tree_health -= 1
		if tree_health == 0:
			$CPUParticles2D.emitting = true
			$Audio/HitSoundEffect.playing = true
			$AnimatedSprite2D.play("choped")
			drop_wood()
		else:
			$AnimatedSprite2D.play("hit")
			$AnimationPlayer.play("hit_effect")
			$CPUParticles2D.emitting = true
			$Audio/HitSoundEffect.playing = true
			await get_tree().create_timer(0.5).timeout
			$AnimatedSprite2D.play("idle")

func drop_wood():
	var wood_instance = wood.instantiate()
	wood_instance.global_position = $Marker2D.global_position
	get_parent().add_child(wood_instance)
	wood_instance.connect("wood_picked", _on_wood_picked)

func _on_wood_picked():
	print("growth_timer started")
	$growth_timer.start()

func _on_growth_timer_timeout():
	tree_health = 3
	$AnimatedSprite2D.play("idle")
