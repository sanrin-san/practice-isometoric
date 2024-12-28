extends StaticBody2D

@onready var coin_loot = preload("res://Interactables/Coin/coin.tscn")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var reward_ammount: int = 10

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Sword"):
		animation_player.play("Destroyed")
		await animation_player.animation_finished
		on_coin_loot()
		queue_free()

func on_coin_loot() -> void:
	var coin = coin_loot.instantiate()
	coin.position = global_position
	coin.ammount = reward_ammount
	get_tree().get_root().add_child(coin)
