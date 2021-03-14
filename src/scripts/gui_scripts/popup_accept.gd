extends Control

export(String) var title_text = "I am popup!"
export(String) var top_text = "not_covered"
export(String) var middle_text = "not_covered"
export(String) var bottom_text = "not_covered"

onready var dialog: AcceptDialog = $dialog
onready var top_text_label: Label = $dialog/container/top
onready var center_text_label: Label = $dialog/container/center
onready var bottom_text_label: Label = $dialog/container/bottom


func _ready():
	update_translation()


func show():
	dialog.popup_centered(Vector2.ZERO)


func update_translation():
	dialog.window_title = tr(title_text)
	top_text_label.text = tr(top_text)
	center_text_label.text = tr(middle_text)
	bottom_text_label.text = tr(bottom_text)


func _on_help_menu_show_guide():
	show()


func _on_help_menu_show_about():
	show()
