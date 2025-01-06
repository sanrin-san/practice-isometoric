extends Node2D

var is_amina_intaract: bool = false


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_interact"):
		if is_amina_intaract == true:
			if Dialogic.current_timeline != null:
				return
			Dialogic.start('test')

func _on_intaract_area_entered(area: Area2D) -> void:
	is_amina_intaract = true

func _on_intaract_area_exited(area: Area2D) -> void:
	is_amina_intaract = false
