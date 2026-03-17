extends Node

const song_item_scene = preload("res://Scenes/song_item.tscn")

func create_song_item(id: String) -> SongItem:
	var song_item = song_item_scene.instantiate()
	song_item.id = id
	return song_item
