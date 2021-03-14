extends Label


func _ready():
	update_translation()

func update_translation():
	self.text = tr("values")
