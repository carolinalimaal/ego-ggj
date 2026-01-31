class_name LevelExit
extends Area2D

@export_file("*.tscn") var next_scene_path: String


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if next_scene_path == "":
			print("ERRO: Nenhuma cena definida no LevelExit!")
			return
		GameManager.change_level(next_scene_path)
