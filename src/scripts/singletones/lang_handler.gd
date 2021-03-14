extends Node

const LANGUAGES = ["ru", "en"] 
var current_lang 

func _ready():
	current_lang = "ru"
	TranslationServer.set_locale(current_lang)


func change_lang(lang):
	if lang in LANGUAGES:
		current_lang = lang
		TranslationServer.set_locale(current_lang)
		update_translation()
		print("Language changed to '%s'" % current_lang)
	else:
		print("'%s' is not supported" % lang)


func update_translation():
	get_tree().call_group("translatable", "update_translation")
	pass
