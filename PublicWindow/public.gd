extends Window
class_name PublicWindow

@onready var leader_name: Label = %LeaderNameLabel

@onready var thumbnail: TextureRect = %Thumbnail
@onready var hidden_thumbnail: TextureRect = %HiddenThumbnail
@onready var source: Label = %Source
@onready var song_name: Label = %SongName
@onready var artist: Label = %Artist


func _ready() -> void:
	Global.public_window = self
	#show()
	SignalManager.starting_song.connect(_on_starting_song)

func hide_infos():
	thumbnail.hide()
	hidden_thumbnail.show()
	
	for info in [source, song_name, artist]:
		info.text = ""
		info.hide()

func show_infos():
	pass

func _on_starting_song(id: String):
	pass
