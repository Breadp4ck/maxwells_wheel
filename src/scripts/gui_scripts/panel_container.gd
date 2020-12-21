extends Control

export(int) var min_size_x = 0
export(int) var min_size_y = 0

func _ready():
	self.rect_min_size = Vector2(min_size_x, min_size_y)
	
