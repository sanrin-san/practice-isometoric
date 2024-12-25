extends Area2D

@export var transparency: float = 0.3
@export var opaque: float = 1.0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_parent().modulate.a = transparency

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_parent().modulate.a = opaque
