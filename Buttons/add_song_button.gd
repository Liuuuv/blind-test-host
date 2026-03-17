extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	var song_path: String = await Global.select_song_dialog.ask_for_song(Tools.filepath_to_global("O:/PPPlayerGodot/downloads/"))
	print("song_path ", song_path)
	if song_path != "":
		SongManager.add_song_from_file(song_path)
