extends StaticBody2D

var player_entered = false

func _ready() -> void:
	$door_label.visible = false

func _input(event: InputEvent) -> void:
	if player_entered == true && PlayerData.key >= 1:
		if Input.is_action_just_pressed("ui_interact"):
			$AnimationPlayer.play("Opened")
			PlayerData.key -= 1
			print("key: ", PlayerData.key)

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		PlayerData.player_position = body.position
		player_entered = true
		$door_label.visible = true

func _on_player_detector_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_entered = false
		$door_label.visible = false

func _on_change_level_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		call_deferred("_enter_house_scene")

func _enter_house_scene() -> void:
	get_tree().change_scene_to_file("res://Levels/level_2.tscn")
