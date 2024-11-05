extends Area2D

@export var loot_sfx: AudioStreamPlayer2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("lootable"):
		if loot_sfx != null:
			loot_sfx.play()
		print("+1 item")
		area.get_parent().queue_free()
