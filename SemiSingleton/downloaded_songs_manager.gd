extends Node



func get_all_ids_from_dir() -> Array[String]:
	
	var id: String
	var dir = DirAccess.open(Global.get_downloads_path())
	var ids : Array[String] = []

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			id = file_name.get_basename()
			if not Tools.is_id(id) or not SongInfosManager.song_infos.has(id):
				file_name = dir.get_next()
				continue
			if not dir.current_is_dir():
				var extension = file_name.get_extension()
				if extension in ["mp3", "wav"]: ## TEMP
					ids.append(id)
					
			file_name = dir.get_next()
	
	return ids
