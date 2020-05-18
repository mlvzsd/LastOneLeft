extends CanvasLayer

func _ready():
	print("HUD: ready")

func set_life(value : int):
	for i in range(1, 7):
		get_node(str("Hearts/Heart", i)).frame = int(i <= value)
