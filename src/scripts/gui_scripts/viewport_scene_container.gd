extends VSplitContainer


func _ready() -> void:
	var size = get_viewport_rect().size.y
	self.split_offset = size * 9/10
