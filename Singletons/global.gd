extends Node




const DOWNLOADED_SONGS_PATH: String = "res://downloaded_songs.json"
const LOGS_PATH: String = "res://logs.json"
const CACHE_DIR_NAME: String = "_cache" ## in downloads
const default_downloads_path: String = "res://downloads/"
#const song_item_scene = preload("res://Misc/song_item.tscn")
#const download_item_scene = preload("res://Misc/download_item.tscn")


var public_window: PublicWindow
var select_song_dialog: SelectSongDialog
var current_playlist: CurrentPlaylist
var music_player: MusicPlayer
var song_panel: SongPanel

var downloaded_songs: Dictionary = {}


func _ready() -> void:
	initialize.call_deferred()
	

func initialize() -> void:
	print("initializing global..")
	SettingsManager.initialize()
	SongInfosManager.initialize()
	initialize_downloaded_songs()
	#print("settings ", settings)


func initialize_downloaded_songs() -> void:
	print("initializing downloaded songs")
	load_downloaded_songs()
	if downloaded_songs == {}:
		save_downloaded_songs()


func load_downloaded_songs() -> void:
	print("loading song infos..")
	downloaded_songs = Tools.load_json_file(DOWNLOADED_SONGS_PATH)

func save_downloaded_songs() -> void:
	Tools.write_json_file(downloaded_songs, DOWNLOADED_SONGS_PATH)

func get_downloads_path() -> String: ## TEMP
	return "res://downloads/"



func generate_new_id() -> String:
	var last_id: String = SettingsManager.settings.get("last_id")
	
	## next id
	var next_id: String = Tools.get_next_id(last_id)
	
	SettingsManager.change_settings("last_id", next_id)
	
	return next_id




func delete_song(id: String):
	print("Deleting song from ID %s" % id)
	var song_info: Dictionary = SongInfosManager.song_infos.get(id)
	var error: Error
	if song_info:
		var extension: String = song_info.get("extension", "")
		if extension:
			var full_path: String = get_downloads_path() + id + "." + extension
			error = DirAccess.remove_absolute(full_path)
			if error != OK:
				push_error("delete_song, can't delete the song %s" % full_path)
				print("delete_song, Can't delete the file. can't remove the file %s" % full_path)
			
			if not downloaded_songs.erase(song_info.get("video_id")):
				print("delete_song, the video_id was not available in downloaded_songs for the ID: %s" % id)
			save_downloaded_songs()
			
			## TEMP TO FIX
			#var thumbnail_path: String = get_thumbnail_path(id)
			#if thumbnail_path != "":
				#error = DirAccess.remove_absolute(thumbnail_path)
				#if error != OK:
					#push_error("delete_song, Can't delete the thumbnail %s" % thumbnail_path)
					#print("delete_song, Can't delete the thumbnail %s" % full_path)
			
			SongInfosManager.song_infos.erase(id)
			SongInfosManager.save_song_infos()
			
			if current_playlist.content_ids.has(id):
				current_playlist.content_ids.erase(id)
			
		else:
			print("delete_song, Can't delete the song. no extension found in song_infos for the ID: %s" % id)
			return
	else:
		print("delete_song, Can't delete the song. Can't find the song info for the ID: %s" % id)
		return
	
	print("Successfully deleted the song for the ID: %s" % id)
