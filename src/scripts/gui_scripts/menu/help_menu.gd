extends MenuButton

enum MenuCells {
	ABOUT,
	GUIDE,
}

var popup_menu: PopupMenu

signal show_guide
signal show_about

func _ready():
	popup_menu = get_popup()
	popup_menu.connect("id_pressed", self, "_on_popup_pressed")
	update_translation()

func update_translation():
	self.text = tr("help")
	popup_menu.set_item_text(MenuCells.ABOUT, tr("about_programm"))
	popup_menu.set_item_text(MenuCells.GUIDE, tr("guide_programm"))

func _on_popup_pressed(id):
	match id:
		MenuCells.ABOUT:
			emit_signal("show_about")
		MenuCells.GUIDE:
			emit_signal("show_guide")
