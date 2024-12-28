extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		PlayerData.key += 1
		$AnimationPlayer.play("Collected")
		await $AnimationPlayer.animation_finished
		queue_free()