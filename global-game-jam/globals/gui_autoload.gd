extends CanvasLayer

var gui_components : Dictionary = {
	"pause_menu" : "uid://couqdco7mtoxw"
}

var resolutions: Dictionary = {
	"1280 x 720": Vector2i(1280, 720),   # HD 
	"1920 x 1080": Vector2i(1920, 1080), # Full HD
	"2560 x 1440": Vector2i(2560, 1440), # 2K
	"3840 x 2160": Vector2i(3840, 2160)  # 4K
}

#func _ready() -> void:
	#for i in gui_components:
		#var new_scene = load(gui_components[i]).instantiate()
		#add_child(new_scene)
		#new_scene.hide()

#func center_window() -> void:
	#var screen_center = DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	#var window_size = get_window().get_size_with_decorations()
	#get_window().set_position(screen_center - window_size / 2)

func center_window() -> void:
	var window = get_window()
	window.move_to_center()
