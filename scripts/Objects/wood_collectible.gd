extends StaticBody2D

signal wood_picked

func _ready():
	spawn_log()

func spawn_log():
	$AnimatedSprite2D.play("spawn")
	await get_tree().create_timer(0.6).timeout
	$logAnimation.play("idle")
	$AnimatedSprite2D.play("idle")
	$pickArea.monitoring = true

func _on_pick_area_body_entered(body):
	if body.is_in_group("player"):
		print("+1 wood")
		wood_picked.emit()
		$PickSFX.play()
		visible = false

func _on_pick_sfx_finished() -> void:
	queue_free()
