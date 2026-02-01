extends Node2D

var is_green: bool = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.play("piscando")

func _process(_delta: float) -> void:
	if is_green:
		return
	if Dialogic.VAR.get_variable("pegouMascaraCamaleao") == true:
		is_green = true
		animated_sprite.play("default")
