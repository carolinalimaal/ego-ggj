extends StaticBody2D

var active: bool = false
var can_activate: bool = false
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _unhandled_input(_event: InputEvent) -> void:
	if can_activate and Input.is_action_just_pressed("dialogic_default_action") and !active:
		active = true
		sprite.animation = "activated"


func _on_player_colision_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_activate = true



func _on_player_colision_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_activate = false
