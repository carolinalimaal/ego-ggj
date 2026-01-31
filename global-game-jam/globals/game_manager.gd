extends Node

signal player_died

var can_move: bool = true

func _ready() -> void:
	Dialogic.timeline_started.connect(_on_dialogue_started)
	Dialogic.timeline_ended.connect(_on_dialogue_ended)
	
	player_died.connect(_on_player_died)

func _on_dialogue_started() -> void:
	can_move = false

func _on_dialogue_ended() -> void:
	can_move = true

func _on_player_died() -> void:
	GlobalRefs.player.queue_free()
	pass
	# TODO: Tela de GameOver
