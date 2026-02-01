extends Control

@onready var main_menu_buttons: VBoxContainer = $Menu

@onready var start_button: Button = $Menu/Control/Start
@onready var quit_button: Button = $Menu/Control3/Quit

func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	start_button.grab_focus()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/cutscenes/cutscene_inicial.tscn")
	pass

func _on_quit_button_pressed() -> void:
	get_tree().quit()
