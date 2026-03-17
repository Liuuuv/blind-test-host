extends VBoxContainer

const line_scene = preload("res://Scenes/song_info_line.tscn")

func _ready() -> void:
	initialize.call_deferred()
	

func initialize() -> void:
	load_song_info("d")

func load_song_info(id: String):
	var song_info = SongInfosManager.song_infos.get(id)
	print("song_info ",song_info)
	if song_info:
		for info_name in song_info.keys():
			print("info_name ", info_name)
			var line: SongInfoLine = line_scene.instantiate()
			setup_line.call_deferred(line, song_info, info_name)
			add_child(line)

func setup_line(line: SongInfoLine, song_info: Dictionary, info_name: String):
	line.info_name_label.text = info_name
	line.text_edit.text = song_info.get(info_name, "")
	if info_name in ["extension", "thumbnail_path", "video_id", "artist_id"]:
		line.text_edit.editable = false
