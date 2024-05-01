extends StaticBody2D

var tree_health = 3
var is_area_entered = false

func _process(delta):
	if is_area_entered:
		if Input.is_action_just_pressed("attack"):
			$AnimatedSprite2D.play("hit")

func _on_chop_area_body_entered(body):
	if body.has_method() == "player":
		is_area_entered = true

func _on_chop_area_body_exited(body):
	if body.has_method() == "player":
		is_area_entered = false
