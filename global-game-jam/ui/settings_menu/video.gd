#extends VBoxContainer
#
#@onready var resolution_option_button: OptionButton = $HBoxContainer/Resolution
#@onready var fullscreen_checkbox: CheckBox = $HBoxContainer2/Fullscreen
#
#var resolutions = {
	#"3840 x 2160": Vector2i(3840,2160),
	#"2560 x 1440": Vector2i(2560,1440),
	#"1920 x 1080": Vector2i(1920,1080),
	#"1600 x 900": Vector2i(1600,900),
	#"1440 x 900": Vector2i(1440,900),
	#"1366 x 768": Vector2i(1366,768),
	#"1280 x 720": Vector2i(1280,720),
	#"1024 x 600": Vector2i(1024,600),
	#"800 x 600": Vector2i(800,600)
#}
#
#func _ready() -> void:
	#resolution_option_button.item_selected.connect(_on_resolution_option_button_item_selected)
	#fullscreen_checkbox.toggled.connect(_on_fullscreen_checkbox_toggled)
	#add_resolution()
#
#func add_resolution() -> void:
	#for r in GUI.resolutions:
		#resolution_option_button.add_item(r)
#
#func update_button_value() -> void:
	#var window_size_string = str(get_window().size.x, " x ", get_window().size.y)
	#var resolution_index = GUI.resolutions.keys().find(window_size_string)
	#resolution_option_button.selected = resolution_index
#
#func _on_resolution_option_button_item_selected(index: int) -> void:
	#var key = resolution_option_button.get_item_text(index)
	#get_window().set_size(GUI.resolutions[key])
	#GUI.center_window()
#
#func _on_fullscreen_checkbox_toggled(toggled_on: bool) -> void:
	#if toggled_on:
		#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		#return
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
