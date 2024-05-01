extends StaticBody2D

var tree_health = 3
var is_area_entered = false

func _on_chop_area_body_entered(body):
	if body.name == "player":
		is_area_entered = true

func _on_chop_area_body_exited(body):
	if body.name == "player":
		is_area_entered = false

func _on_player_player_attacking():
	if is_area_entered:
		if tree_health > 0:
			tree_health -= 1
			if tree_health == 0:
				$AnimatedSprite2D.play("choped")
				$growth_timer.start()
			else:
				$AnimatedSprite2D.play("hit")
				await get_tree().create_timer(0.5).timeout
				$AnimatedSprite2D.play("idle")

func _on_growth_timer_timeout():
	tree_health = 3
	$AnimatedSprite2D.play("idle")
