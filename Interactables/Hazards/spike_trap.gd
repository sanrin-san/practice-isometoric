extends Area2D

@export var damage: float = -0.25

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		PlayerData.update_player_health(damage)
		print(PlayerData.health)
