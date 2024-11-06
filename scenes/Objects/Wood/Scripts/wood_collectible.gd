extends StaticBody2D

signal item_picked

func _ready():
	spawn_log()

func spawn_log():
	$AnimatedSprite2D.play("spawn")
	await get_tree().create_timer(0.6).timeout
	$logAnimation.play("idle")
	$AnimatedSprite2D.play("idle")
	$pickArea.monitoring = true
