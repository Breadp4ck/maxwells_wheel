extends Control

signal time_updated(time)

func _ready():
	pass


func _on_GUI_resized():
	print("Viewport Resolution is: ", get_viewport_rect().size)


func _on_world_time_updated(time):
	emit_signal("time_updated", time)

