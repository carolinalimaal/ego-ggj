extends Control

@onready var resume_button: Button = $Panel/VBoxContainer/Control/Resume
@onready var settings_button: Button = $Panel/VBoxContainer/Control2/Settings
@onready var main_menu_button: Button = $Panel/VBoxContainer/Control3/MainMenu
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var _is_open : bool = false

func _ready() -> void:
	resume_button.pressed.connect(_on_resume_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)
	
	animation_player.play("RESET")
	
	self.visible = false

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause"):
		if _is_open and get_tree().paused:
			_resume()
		elif !_is_open and !get_tree().paused:
			_pause()

func _pause() -> void:
	get_tree().paused = true
	_is_open = true
	self.visible = true
	animation_player.play("pause")
	resume_button.grab_focus()

func _resume() -> void:
	get_tree().paused = false
	_is_open = false
	self.visible = false
	animation_player.play_backwards("pause")

func _on_resume_button_pressed() -> void:
	_resume()

func _on_settings_button_pressed() -> void:
	# TODO: Funcionalidade de abrir menu de opcoes
	pass

func _on_main_menu_button_pressed() -> void:
	_resume()
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")
