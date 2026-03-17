extends HSlider
class_name VolumeSlider

var is_dragging: bool = false

func _ready() -> void:
	value = 0.0
	
	drag_started.connect(_on_drag_started)
	drag_ended.connect(_on_drag_ended)
	value_changed.connect(_on_value_changed)
	
	SongManager.has_stream_changed.connect(_on_has_stream_changed)
	
func _on_drag_started():
	is_dragging = true

func _on_drag_ended(value_changed: bool):
	return
	#is_dragging = false
	#if value_changed:
		#Global.music_player.set_volume(value)

func _on_value_changed(value: float):
	Global.music_player.set_volume(value)

func _on_has_stream_changed():
	return
	#if SongManager.has_stream:
		#editable = true
	#else:
		#editable = false
