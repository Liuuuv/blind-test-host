extends VBoxContainer
class_name SongInfosContainer

const line_scene = preload("res://Scenes/song_info_line.tscn")

func _ready() -> void:
	Global.song_infos_container = self
	
	clear_lines()
	
	initialize.call_deferred()
	

func initialize() -> void:
	load_song_info("d")

func clear_lines() -> void:
	for child in get_children():
		if child is SongInfoLine:
			child.queue_free()

func load_song_info(id: String):
	clear_lines()
	var song_info = SongInfosManager.song_infos.get(id)
	print("song_info ",song_info)
	if song_info:
		for info_name in song_info.keys():
			print("info_name ", info_name)
			var line: SongInfoLine = line_scene.instantiate()
			setup_line.call_deferred(line, song_info, info_name)
			line.id = id
			add_child(line)

func setup_line(line: SongInfoLine, song_info: Dictionary, info_name: String):
	line.info_name_label.text = info_name
	line.line_edit.text = song_info.get(info_name, "")
	if info_name in ["extension", "thumbnail_path", "video_id", "artist_id"]:
		line.line_edit.editable = false
