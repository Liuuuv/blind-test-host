extends HBoxContainer
class_name SongInfoLine

@onready var info_name_label: Label = $InfoNameLabel
@onready var line_edit: LineEdit = $LineEdit

var id: String = ""


func _ready() -> void:
	pass

func update_song_info():
	if id == "":
		push_error("line not associated with an id")
		return
	
	var song_info = SongInfosManager.song_infos.get(id)
	var info_name: String =info_name_label.text
	if song_info.get(info_name) != line_edit.text:
		SongInfosManager.change_song_info(id, info_name, line_edit.text)
		print("updated id: %s, info: %s to %s" % [id, info_name, line_edit.text])
		Global.current_playlist.reload_song_items()
