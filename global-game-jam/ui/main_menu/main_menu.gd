extends Control

@onready var menu: VBoxContainer = $Menu
@onready var settings: VBoxContainer = $Settings
@onready var video: VBoxContainer = $Video
@onready var audio: VBoxContainer = $Audio

@onready var back_button: Button = $Control/Back

@onready var start_button: Button = $Menu/Control/Start
@onready var settings_button: Button = $Menu/Control2/Settings
@onready var quit_button: Button = $Menu/Control3/Quit

@onready var video_button: Button = $Settings/Control/Video
@onready var audio_button: Button = $Settings/Control2/Audio

@onready var resolution_option_button: OptionButton = $Video/HBoxContainer/Resolution
@onready var fullscreen_checkbox: CheckBox = $Video/HBoxContainer2/Fullscreen

@onready var master_slider: HSlider = $Audio/HBoxContainer/master_slider
@onready var music_slider: HSlider = $Audio/HBoxContainer2/music_slider
@onready var sfx_slider: HSlider = $Audio/HBoxContainer3/sfx_slider

const MIN_DB: float = -60.0
const MAX_DB: float = 0.0

func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)
	
	start_button.pressed.connect(_on_start_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	video_button.pressed.connect(_on_video_button_pressed)
	audio_button.pressed.connect(_on_audio_button_pressed)
	
	resolution_option_button.item_selected.connect(_on_resolution_option_button_item_selected)
	fullscreen_checkbox.toggled.connect(_on_fullscreen_checkbox_toggled)
	
	#master_slider.changed.connect(_on_master_volume_changed)
	#music_slider.changed.connect(_on_music_volume_changed)
	#sfx_slider.changed.connect(_on_sfx_volume_changed)
	
	settings.visible = false
	video.visible = false
	audio.visible = false
	
	add_resolution()
	_sync_sliders()
	
	start_button.grab_focus()

func _on_back_button_pressed() -> void:
	if settings.visible:
		settings.visible = false
		menu.visible = true
		back_button.visible = false
		start_button.grab_focus()
	elif video.visible or audio.visible:
		video.visible = false
		audio.visible = false
		settings.visible = true
		video_button.grab_focus()

# == MAIN MENU ==

func _on_start_button_pressed() -> void:
	pass

func _on_settings_button_pressed() -> void:
	menu.visible = false
	settings.visible = true
	back_button.get_parent().visible = true
	if settings.visible:
		update_button_value()
	video_button.grab_focus()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

# == SETTINGS ==
func _on_video_button_pressed() -> void:
	settings.visible = false
	video.visible = true
	back_button.get_parent().visible = true
	resolution_option_button.grab_focus()

func _on_audio_button_pressed() -> void:
	settings.visible = false
	audio.visible = true
	back_button.get_parent().visible = true
	master_slider.grab_focus()

# == VIDEO ==
func _on_resolution_option_button_item_selected(index: int) -> void:
	var key = resolution_option_button.get_item_text(index)
	get_window().set_size(GUI.resolutions[key])
	GUI.center_window()

func _on_fullscreen_checkbox_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		return
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func add_resolution() -> void:
	for r in GUI.resolutions:
		resolution_option_button.add_item(r)

func update_button_value() -> void:
	var window_size_string = str(get_window().size.x, " x ", get_window().size.y)
	var resolution_index = GUI.resolutions.keys().find(window_size_string)
	resolution_option_button.selected = resolution_index

# == AUDIO == 
func _on_master_volume_changed(value: float) -> void:
	_set_volume("Master", value)

func _on_music_volume_changed(value: float) -> void:
	_set_volume("Music", value)

func _on_sfx_volume_changed(value: float) -> void:
	_set_volume("SFX", value)

func _sync_sliders():
	master_slider.value = _db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	music_slider.value = _db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	sfx_slider.value = _db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))

func _slider_to_db(value: float) -> float:
	if value <= 0:
		return MIN_DB
	
	var linear = value / 100
	var db = linear_to_db(linear)
	return clamp(db, MIN_DB, MAX_DB)

func _db_to_slider(db: float) -> float:
	if db <= MIN_DB:
		return 0.0
	
	var linear = db_to_linear(db)
	return clamp(linear * 100, 0, 100)

func _set_volume(bus_name: String, value: float) -> void:
	var db = _slider_to_db(value)
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, db)
	AudioServer.set_bus_mute(bus_index, db <= MIN_DB)
