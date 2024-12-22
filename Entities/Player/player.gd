extends CharacterBody2D

const ACCELERATION: int = 600
const FRICTION: int = 400

var input: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2(0, -1)

@export var speed: int = 70
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

enum player_state {
	IDLE, MOVE, ATTACK, DEAD
}
var current_state = player_state.IDLE

func _process(delta: float) -> void:
	match current_state:
		player_state.MOVE:
			player_movement(delta)
		player_state.IDLE:
			player_idle(delta)
		player_state.ATTACK:
			sword_attack(delta)

func diagonal_movement(direction: Vector2) -> Vector2:
	# アイソメトリック方向に変換
	return Vector2(
		direction.x - direction.y,
		(direction.x + direction.y) / 2
	)

func player_input() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func player_movement(delta: float) -> void:
	input = player_input()
	
	if input != Vector2.ZERO:
		last_direction = input.normalized()
		velocity = diagonal_movement(input) * speed
		velocity = velocity.limit_length(speed)
		set_animation_state()  # アニメーションを更新
		animation_state.travel("Move")
	else:
		current_state = player_state.IDLE
	
	if Input.is_action_just_pressed("ui_sword"):
		current_state = player_state.ATTACK
	
	move_and_slide()

func player_idle(delta: float) -> void:
	input = player_input()
	
	if Input.is_action_just_pressed("ui_sword"):
		current_state = player_state.ATTACK
		return
	
	if input != Vector2.ZERO:
		last_direction = input.normalized()
		current_state = player_state.MOVE
	else:
		if velocity.length() > FRICTION * delta:
			velocity -= velocity.normalized() * FRICTION * delta
		else:
			velocity = Vector2.ZERO
		move_and_slide()
		animation_state.travel("Idle")

func sword_attack(delta: float) -> void:
	set_animation_state(last_direction)  # 最後の入力方向で設定
	animation_state.travel("Attack")

func reset_state() -> void:
		current_state = player_state.MOVE

func set_animation_state(forced_direction: Vector2 = Vector2.ZERO) -> void:
	var direction = forced_direction if forced_direction != Vector2.ZERO else input
	animation_tree.set("parameters/Idle/blend_position", direction)
	animation_tree.set("parameters/Move/blend_position", direction)
	animation_tree.set("parameters/Attack/blend_position", direction)
