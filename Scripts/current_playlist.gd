extends VBoxContainer
class_name CurrentPlaylist

var content_ids: Array[String] = []

func _ready() -> void:
	Global.current_playlist = self
	initialize.call_deferred()
	
	SignalManager.downloads_folder_changed.connect(_on_downloads_folder_changed)



func initialize():
	initialize_content_ids()
	reload_song_items()

func initialize_content_ids():
	var all_ids: Array[String] = DownloadedSongsManager.get_all_ids_from_dir()
	content_ids = all_ids ## TEMP

func reload_song_items() -> void:
	initialize_content_ids() ## TEMP
	
	for child in get_children():
		child.queue_free()
	
	
	for index in range(content_ids.size()):
		var song_item = SongItemManager.create_song_item(content_ids[index])
		song_item.location = "current_playlist"
		song_item.index = index
		add_child(song_item)

func clear_song_items() -> void:
	for child in get_children():
		child.queue_free()
	
	content_ids = []


func _on_downloads_folder_changed():
	Global.current_playlist.reload_song_items()
