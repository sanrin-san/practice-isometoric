extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var ammount: int = 1

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		PlayerData.coin_number += ammount
		animation_player.play("Collected")
		await animation_player.animation_finished
		queue_free()
