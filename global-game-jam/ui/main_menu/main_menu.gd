extends Control

@onready var main_menu_buttons: VBoxContainer = $Menu

@onready var start_button: Button = $Menu/Control/Start
@onready var quit_button: Button = $Menu/Control3/Quit
@onready var sfx_button: AudioStreamPlayer = $sfx_button

func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	start_button.focus_entered.connect(_on_focus_entered)
	quit_button.focus_entered.connect(_on_focus_entered)
	
	start_button.grab_focus()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/cutscenes/cutscene_inicial.tscn")
	pass

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_focus_entered() -> void:
	sfx_button.play()
