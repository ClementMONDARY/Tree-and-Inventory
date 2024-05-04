extends StaticBody2D

var tree: Node
signal wood_picked

func _ready():
	spawnLog()

func spawnLog():
	$AnimatedSprite2D.play("spawn")
	await get_tree().create_timer(0.6).timeout
	$AnimationPlayer.play("idle")
	$AnimatedSprite2D.play("idle")
	$pickArea.monitoring = true

func _on_pick_area_body_entered(body):
	if body.name == "player":
		print("+1 wood")
		wood_picked.emit()
		queue_free()
