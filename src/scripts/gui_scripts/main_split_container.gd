extends HSplitContainer


func _ready():
	var size = get_viewport_rect().size.x
	self.split_offset = size * 1/3
