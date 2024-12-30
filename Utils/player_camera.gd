extends Camera2D

@export var max_zoom: float = 4
@export var min_zoom: float = 1

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_zoom_in"):
		zoom = Vector2.ONE * clamp(zoom.x + 0.5, min_zoom, max_zoom)
	elif event.is_action_pressed("ui_zoom_out"):
		zoom = Vector2.ONE * clamp(zoom.x - 0.5, min_zoom, max_zoom)
