extends StaticBody2D

var tree: Node
var is_area_entered = false
signal wood_picked

func _ready():
	spawnLog()

func _process(delta):
	if is_area_entered and Input.is_action_just_pressed("collect"):
		print("+1 wood")
		wood_picked.emit()
		queue_free() 

func spawnLog():
	$AnimatedSprite2D.play("spawn")
	await get_tree().create_timer(0.6).timeout
	$logAnimation.play("idle")
	$AnimatedSprite2D.play("idle")
	$pickArea.monitoring = true

func _on_pick_area_body_entered(body):
	if body.name == "player":
		is_area_entered = true
		$collect_buttonAnimation.play("collect_button_show")

func _on_pick_area_body_exited(body):
	if body.name == "player":
		is_area_entered = false
		$collect_buttonAnimation.play("collect_button_hide")
