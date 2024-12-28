class_name PlayerData
extends Node

static var health: float = 12
static var coin_number: int = 0
static var key = 0

static func update_player_health(amount: float) -> void:
	health += amount
