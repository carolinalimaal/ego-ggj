class_name Checkpoint
extends Area2D

@export var is_start_point: bool = false

func _ready() -> void:
	body_entered.connect(_on_player_entered)
	
	if is_start_point:
		GameManager.set_checkpoint(global_position)

func _on_player_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.set_checkpoint(global_position)
