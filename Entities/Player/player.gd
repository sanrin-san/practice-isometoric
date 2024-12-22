extends CharacterBody2D

const acceleration: int = 600
const friction: int = 400

var input: Vector2 = Vector2.ZERO

@export var speed: int = 70
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

func _process(delta: float) -> void:
	player_movement(delta)

func diagonal_movement(diagonal) -> Vector2:
	var screen_pos: Vector2 = Vector2()
	screen_pos.x = diagonal.x - diagonal.y
	screen_pos.y = (diagonal.x + diagonal.y) / 2
	
	return screen_pos

func player_movement(delta: float) -> void:
	input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input != Vector2.ZERO:
		set_animation_state()
		animation_state.travel("Move")
		velocity = velocity.limit_length(speed)
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			animation_state.travel("Idle")
			velocity = Vector2.ZERO
	
	velocity += diagonal_movement(input * acceleration * delta)
	move_and_slide()

func set_animation_state() -> void:
	animation_tree.set("parameters/Idle/blend_position", input)
	animation_tree.set("parameters/Move/blend_position", input)
	animation_tree.set("parameters/Attack/blend_position", input)
