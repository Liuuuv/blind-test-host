extends Node


var settings: Dictionary = DEFAULT_SETTINGS
var DEFAULT_SETTINGS: Dictionary = {
	"downloads_path": Global.default_downloads_path,
	"last_id": "",
	"user_path": "",
}
const SETTINGS_PATH: String = "res://settings.json"

func initialize() -> void:
	print("initializing settings..")
	load_settings()
	if settings == {}:
		settings = DEFAULT_SETTINGS
		save_settings()
		load_settings()

func load_settings() -> void:
	print("loading settings..")
	settings = Tools.load_json_file(SETTINGS_PATH)
	if settings != {}:
		SignalManager.settings_changed.emit()

func change_settings(setting_name: String, value: Variant) -> void:
	settings.set(setting_name, value)
	print("settings changed ", setting_name, " ", value)
	save_settings()


func save_settings() -> void:
	Tools.write_json_file(settings, SETTINGS_PATH)
