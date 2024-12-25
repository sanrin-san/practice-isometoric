extends CanvasLayer

@onready var heart: Sprite2D = $Heart
@onready var coin_label: Label = $CoinLabel

const heart_row_size: int = 8
const heart_offset: int = 16

func _ready() -> void:
	for i in PlayerData.health:
		var new_heart: Sprite2D = Sprite2D.new()
		new_heart.texture = heart.texture
		new_heart.hframes = heart.hframes
		heart.add_child(new_heart)

func _process(delta: float) -> void:
	coin_label.text = var_to_str(PlayerData.coin_number)
	
	for heart_child in heart.get_children():
		var index = heart_child.get_index()
		var x = (index % heart_row_size) * heart_offset
		var y = (index / heart_row_size) * heart_offset
		heart_child.position = Vector2(x, y)
		
		var last_heart = floor(PlayerData.health)
		if index > last_heart:
			heart_child.frame = 0
		if index == last_heart:
			heart_child.frame = (PlayerData.health - last_heart) * 4
		if index < last_heart:
			heart_child.frame = 4
