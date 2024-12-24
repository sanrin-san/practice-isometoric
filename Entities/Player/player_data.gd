class_name PlayerData
extends Node

static var health: float = 12

static func update_player_health(amount: float) -> void:
	health += amount
