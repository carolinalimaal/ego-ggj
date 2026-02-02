extends Control


func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("dialogic_default_action"):
		GameManager.change_level("res://ui/main_menu/main_menu.tscn")
