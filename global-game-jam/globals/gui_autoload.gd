extends CanvasLayer

var gui_components : Dictionary = {
	"pause_menu" : "uid://couqdco7mtoxw"
}

var resolutions = {
	"3840 x 2160": Vector2i(3840,2160),
	"2560 x 1440": Vector2i(2560,1440),
	"1920 x 1080": Vector2i(1920,1080),
	"1600 x 900": Vector2i(1600,900),
	"1440 x 900": Vector2i(1440,900),
	"1366 x 768": Vector2i(1366,768),
	"1280 x 720": Vector2i(1280,720),
	"1024 x 600": Vector2i(1024,600),
	"800 x 600": Vector2i(800,600)
}

func _ready() -> void:
	for i in gui_components:
		var new_scene = load(gui_components[i]).instantiate()
		add_child(new_scene)
		new_scene.hide()

func center_window() -> void:
	var screen_center = DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(screen_center - window_size / 2)
