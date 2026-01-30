extends Control

@onready var pause_panel: Panel = $Panel
@onready var settings_menu: Control = $SettingsMenu # Arraste a cena reutilizável para o tscn do pause

@onready var resume_button: Button = $Panel/Menu/Control/Resume
@onready var settings_button: Button = $Panel/Menu/Control2/Settings
@onready var main_menu_button: Button = $Panel/Menu/Control3/MainMenu

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _is_open : bool = false

func _ready() -> void:
	resume_button.pressed.connect(_resume)
	settings_button.pressed.connect(_on_settings_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	
	settings_menu.back_pressed.connect(_on_settings_back)
	settings_menu.hide()
	self.visible = false

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause"):
		if _is_open and get_tree().paused:
			_resume()
		elif !_is_open and !get_tree().paused:
			_pause()

func _on_settings_pressed() -> void:
	pause_panel.hide()
	settings_menu.show()
	settings_menu._show_tab(settings_menu.settings_hub)

func _on_settings_back() -> void:
	pause_panel.show()
	settings_button.grab_focus()

func _pause() -> void:
	get_tree().paused = true
	_is_open = true
	self.visible = true
	pause_panel.show()
	settings_menu.hide()
	animation_player.play("pause")
	resume_button.grab_focus()

func _resume() -> void:
	get_tree().paused = false
	_is_open = false
	self.visible = false
	animation_player.play_backwards("pause")

func _on_main_menu_pressed() -> void:
	_resume()
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")
