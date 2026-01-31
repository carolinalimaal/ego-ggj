class_name Killzone
extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("player morreu")
		GameManager.player_died.emit()
	elif body is Enemy:
		print("inimigo morreu")
		body.queue_free()
