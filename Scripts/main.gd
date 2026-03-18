extends Node2D
class_name Main

func _ready():
	get_viewport().files_dropped.connect(on_files_dropped)

func on_files_dropped(file_paths: PackedStringArray):
	for file_path in file_paths:
		if file_path.get_extension() in Global.supported_extensions:
			SongManager.add_song_from_file(file_path)
