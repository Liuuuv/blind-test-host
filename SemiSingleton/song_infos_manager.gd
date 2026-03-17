extends Node


const SONG_INFOS_PATH: String = "res://song_infos.json"
var song_infos: Dictionary = {} ## {id: {url, name, extension, release_date, artist, album,...}}

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


func create_song_infos(id: String, infos: Dictionary, extension: String, video_id: String = "", thumbnail_path: String = ""):
	
	change_song_info(id, "display_name", infos.get("title", ""))
	change_song_info(id, "extension", extension)
	change_song_info(id, "video_id", video_id)
	change_song_info(id, "thumbnail_path", thumbnail_path)
	change_song_info(id, "release_date", infos.get("release_date", ""))
	change_song_info(id, "artist", infos.get("channel", ""))
	change_song_info(id, "artist_id", infos.get("channel_id", ""))
	change_song_info(id, "release_year", infos.get("release_year", ""))
	change_song_info(id, "source", infos.get("source", ""))
	change_song_info(id, "song_type", infos.get("song_type", ""))
