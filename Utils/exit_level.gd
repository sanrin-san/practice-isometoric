extends Area2D

@export var exit_scene: PackedScene = preload("res://Levels/level_1.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_packed(exit_scene)
