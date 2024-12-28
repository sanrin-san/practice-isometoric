extends Node2D

@onready var key_scene: PackedScene = preload("res://Interactables/Key/key.tscn")
@onready var key_spawn_point: Marker2D = $"../key_spawn_point"

signal on_enemy_dead

func _ready() -> void:
	print("enemy amount: ", get_child_count())

func _process(delta: float) -> void:
	all_enemy_died()

func all_enemy_died() -> void:
	if get_child_count() <= 0:
		emit_signal("on_enemy_dead")

func on_key_loot() -> void:
	var key = key_scene.instantiate()
	key.position = key_spawn_point.global_position
	get_tree().get_root().add_child(key)

func _on_on_enemy_dead() -> void:
	set_block_signals(true)
	on_key_loot()
