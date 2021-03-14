extends MenuButton

enum MenuCells {
	ENGLISH,
	RUSSIAN,
}

var popup_menu: PopupMenu

signal change_lang(lang)

func _ready():
	popup_menu = get_popup()
	popup_menu.connect("id_pressed", self, "_on_popup_pressed")
	update_translation()

func update_translation():
	self.text = tr("language")
	popup_menu.set_item_text(MenuCells.ENGLISH, tr("english"))
	popup_menu.set_item_text(MenuCells.RUSSIAN, tr("russian"))

func _on_popup_pressed(id):
	match id:
		MenuCells.ENGLISH:
			LangHandler.change_lang("en")
			emit_signal("change_lang", "english")
		MenuCells.RUSSIAN:
			LangHandler.change_lang("ru")
			emit_signal("change_lang", "russian")
