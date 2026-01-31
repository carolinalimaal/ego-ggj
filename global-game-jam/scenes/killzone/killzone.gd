class_name Killzone
extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.player_died.emit()
	elif body is Enemy:
		body.queue_free()
