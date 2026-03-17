extends Node


const SONG_INFOS_PATH: String = "res://song_infos.json"
var song_infos: Dictionary = {} ## {id: {url, name, extension, release_date, artist, album}}

func initialize() -> void:
	print("initializing song infos..")
	load_song_infos()
	if song_infos == {}:
		save_song_infos()

func save_song_infos() -> void:
	Tools.write_json_file(song_infos, SONG_INFOS_PATH)

func load_song_infos() -> void:
	print("loading song infos..")
	song_infos = Tools.load_json_file(SONG_INFOS_PATH)
	if song_infos != {}:
		SignalManager.song_infos_changed.emit()


func change_song_info(id: String, info_name: String, value: Variant) -> void:
	if not song_infos.has(id):
		song_infos.set(id, {})
		
	song_infos.get(id).set(info_name, value)
	#print("song infos changed ", change_settings)
	save_song_infos()
