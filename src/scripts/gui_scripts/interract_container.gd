extends HSplitContainer

func _ready() -> void:
	var size = get_viewport_rect().size.x
	self.split_offset = size * 0.1
