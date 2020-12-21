extends HSplitContainer

var proportion: float = 0.1
var size: float

func _ready() -> void:
	size = get_viewport_rect().size.x
	self.split_offset = size * proportion
