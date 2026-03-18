extends Node


signal downloads_folder_changed() ## emitted when a new song has been added to the downloads folder (added by file, downloaded)
signal settings_changed()
signal song_infos_changed()
signal starting_song(id: int)
