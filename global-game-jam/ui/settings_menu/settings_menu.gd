extends Control

signal back_pressed

@onready var settings_hub: VBoxContainer = $Panel/Settings
@onready var video_menu: VBoxContainer = $Panel/Video
@onready var audio_menu: VBoxContainer = $Panel/Audio

@onready var back_button: Button = $Panel/Control/Back
@onready var video_button: Button = $Panel/Settings/Control/Video
@onready var audio_button: Button = $Panel/Settings/Control2/Audio

@onready var resolution_option_button: OptionButton = $Panel/Video/HBoxContainer/Resolution
@onready var fullscreen_checkbox: CheckBox = $Panel/Video/HBoxContainer2/Fullscreen

@onready var master_slider: HSlider = $Panel/Audio/HBoxContainer/master_slider
@onready var music_slider: HSlider = $Panel/Audio/HBoxContainer2/music_slider
@onready var sfx_slider: HSlider = $Panel/Audio/HBoxContainer3/sfx_slider

const MIN_DB: float = -60.0
const MAX_DB: float = 0.0

func _ready() -> void:
	# Conexões de Navegação
	back_button.pressed.connect(_on_back_button_pressed)
	video_button.pressed.connect(func(): _show_tab(video_menu))
	audio_button.pressed.connect(func(): _show_tab(audio_menu))
	
	# Conexões de Vídeo
	resolution_option_button.item_selected.connect(_on_resolution_option_button_item_selected)
	fullscreen_checkbox.toggled.connect(_on_fullscreen_checkbox_toggled)
	
	# Conexões de Áudio
	master_slider.value_changed.connect(func(val): _set_volume("Master", val))
	music_slider.value_changed.connect(func(val): _set_volume("Music", val))
	sfx_slider.value_changed.connect(func(val): _set_volume("SFX", val))
	
	add_resolution()
	_sync_sliders()
	_show_tab(settings_hub)

func _show_tab(tab: VBoxContainer) -> void:
	settings_hub.visible = (tab == settings_hub)
	video_menu.visible = (tab == video_menu)
	audio_menu.visible = (tab == audio_menu)
	
	# Garante que o botão voltar esteja sempre visível nas configurações
	back_button.get_parent().visible = true
	
	# Foco inicial para controle/teclado
	if tab == settings_hub: video_button.grab_focus()
	elif tab == video_menu: resolution_option_button.grab_focus()
	elif tab == audio_menu: master_slider.grab_focus()

func _on_back_button_pressed() -> void:
	if video_menu.visible or audio_menu.visible:
		_show_tab(settings_hub)
	else:
		back_pressed.emit()
		self.hide()

# == LÓGICA DE VÍDEO ==
#func _on_resolution_option_button_item_selected(index: int) -> void:
	#var key = resolution_option_button.get_item_text(index)
	#get_window().set_size(GameManager.resolutions[key])
	#GameManager.center_window()

func _on_resolution_option_button_item_selected(index: int) -> void:
	var key = resolution_option_button.get_item_text(index)
	
	# Se estiver em Fullscreen, mude para Windowed primeiro
	if get_window().mode == Window.MODE_FULLSCREEN:
		get_window().mode = Window.MODE_WINDOWED
		fullscreen_checkbox.button_pressed = false
	# Aplica o novo tamanho
	get_window().set_size(GameManager.resolutions[key])
	# Dá um tempo para o sistema operacional processar antes de centralizar
	await get_tree().process_frame
	GameManager.center_window()

func _on_fullscreen_checkbox_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if toggled_on else DisplayServer.WINDOW_MODE_WINDOWED)

func add_resolution() -> void:
	resolution_option_button.clear()
	for r in GameManager.resolutions:
		resolution_option_button.add_item(r)
	update_resolution_ui()

func update_resolution_ui() -> void:
	var window_size_string = str(get_window().size.x, " x ", get_window().size.y)
	var resolution_index = GameManager.resolutions.keys().find(window_size_string)
	if resolution_index != -1:
		resolution_option_button.selected = resolution_index

# == LÓGICA DE ÁUDIO == 
func _sync_sliders():
	master_slider.value = _db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	music_slider.value = _db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	sfx_slider.value = _db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))

func _set_volume(bus_name: String, value: float) -> void:
	var bus_index = AudioServer.get_bus_index(bus_name)
	var db = _slider_to_db(value)
	AudioServer.set_bus_volume_db(bus_index, db)
	AudioServer.set_bus_mute(bus_index, db <= MIN_DB)

func _slider_to_db(value: float) -> float:
	return clamp(linear_to_db(value / 100.0), MIN_DB, MAX_DB) if value > 0 else MIN_DB

func _db_to_slider(db: float) -> float:
	return clamp(db_to_linear(db) * 100.0, 0, 100) if db > MIN_DB else 0.0
