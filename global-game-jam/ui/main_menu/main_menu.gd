extends Control

@onready var main_menu_buttons: VBoxContainer = $Menu
@onready var settings_menu: Control = $SettingsMenu

@onready var start_button: Button = $Menu/Control/Start
@onready var settings_button: Button = $Menu/Control2/Settings
@onready var quit_button: Button = $Menu/Control3/Quit

func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	settings_menu.back_pressed.connect(_on_settings_back)
	settings_menu.hide()
	start_button.grab_focus()

func _on_settings_button_pressed() -> void:
	main_menu_buttons.hide()
	settings_menu.show()
	settings_menu._show_tab(settings_menu.settings_hub)

func _on_start_button_pressed() -> void:
	# Lógica para iniciar o jogo
	pass
	
func _on_settings_back() -> void:
	main_menu_buttons.show()
	settings_button.grab_focus()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
