extends CharacterBody2D

@onready var coin_loot = preload("res://Interactables/Coin/coin.tscn")

var current_direction = Vector2()
var change_direction

@export var health: float = 1.0
@export var speed: float = 10.0
@export var attack: float = 1.0

func _ready() -> void:
	change_direction = 3

func _process(delta: float) -> void:
	if health < 1:
		set_death()
		return
	
	patrolling(delta)

func patrolling(delta) -> void:
	if change_direction == 0:
		move_up(delta)
	if change_direction == 1:
		move_down(delta)
	if change_direction == 2:
		move_left(delta)
	if change_direction == 3:
		move_right(delta)

func diagonal_movement(direction: Vector2) -> Vector2:
	# アイソメトリック方向に変換
	return Vector2(
		direction.x - direction.y,
		(direction.x + direction.y) / 2
	)

func move_up(delta) -> void:
	velocity += diagonal_movement(Vector2.UP * speed * delta)
	$AnimationPlayer.play("move_up_right")
	move_and_slide()

func move_down(delta) -> void:
	velocity += diagonal_movement(Vector2.DOWN * speed * delta)
	$AnimationPlayer.play("move_down_left")
	move_and_slide()

func move_left(delta) -> void:
	velocity += diagonal_movement(Vector2.LEFT * speed * delta)
	$AnimationPlayer.play("move_up_left")
	move_and_slide()

func move_right(delta) -> void:
	velocity += diagonal_movement(Vector2.RIGHT * speed * delta)
	$AnimationPlayer.play("move_down_right")
	move_and_slide()

func _on_patroll_timer_timeout() -> void:
	velocity = lerp(velocity, Vector2.ZERO, 1)
	change_path()
	$PatrollTimer.start()

func change_path() -> void:
	change_direction = randi() % 4

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Sword"):
		health -= 1

func set_death() -> void:
	on_coin_loot()
	queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		PlayerData.health -= attack

func on_coin_loot() -> void:
	var coin = coin_loot.instantiate()
	coin.position = global_position
	get_tree().get_root().add_child(coin)
