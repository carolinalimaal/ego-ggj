extends Node

# == SINAIS == 
signal player_died

# == VARIAVEIS GLOBAIS
signal player_ready(player)
var player_ref: Player

var can_move: bool = true
var current_checkpoint_pos: Vector2 = Vector2.ZERO

var resolutions: Dictionary = {
	"1280 x 720": Vector2i(1280, 720),   # HD 
	"1920 x 1080": Vector2i(1920, 1080), # Full HD
	"2560 x 1440": Vector2i(2560, 1440), # 2K
	"3840 x 2160": Vector2i(3840, 2160)  # 4K
}

func _ready() -> void:
	Dialogic.timeline_started.connect(_on_dialogue_started)
	Dialogic.timeline_ended.connect(_on_dialogue_ended)

#func center_window() -> void:
	#var screen_center = DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	#var window_size = get_window().get_size_with_decorations()
	#get_window().set_position(screen_center - window_size / 2)

func center_window() -> void:
	var window = get_window()
	window.move_to_center()

func _on_dialogue_started() -> void:
	can_move = false

func _on_dialogue_ended() -> void:
	can_move = true

# == SISTEMA DE CHECKPOINT E MORTE == 
func set_checkpoint(new_pos: Vector2) -> void:
	current_checkpoint_pos = new_pos

func _on_player_died() -> void:
	player_ref.respawn(current_checkpoint_pos)

# == SISTEMA DE TROCA DE FASES == 
func change_level(next_scene_path: String) -> void:
	current_checkpoint_pos = Vector2.ZERO
	
	call_deferred("_deferred_change_scene", next_scene_path)

func _deferred_change_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)

# == REGISTRAR PLAYER NO GAME == 
func register_player(player: Player) -> void:
	player_ref = player
	if !player_died.is_connected(_on_player_died):
		player_died.connect(_on_player_died)
