extends Node2D

@export var mascara: Masks 

@onready var world_floor: TileMapLayer = $TileLayers/Floor
@onready var yellow_floor: TileMapLayer = $TileLayers/YellowFloor
@onready var purple_floor: TileMapLayer = $TileLayers/PurpleFloor
@onready var camera: PlayerCamera = $PlayerCamera
@onready var checkpoints: Array = $Checkpoints.get_children()

var button_1_pressed: bool = false
var button_2_pressed: bool = false

func _ready() -> void:
	# Pega o retângulo usado pelos tiles (em coordenadas de células)
	var map_rect = world_floor.get_used_rect()
	
	# Pega o tamanho de cada tile (ex: 16x16 ou 32x32)
	var tile_size = world_floor.tile_set.tile_size

	# Calcula os limites em pixels
	var limit_left = map_rect.position.x * tile_size.x
	var limit_top = map_rect.position.y * tile_size.y
	var limit_right = map_rect.end.x * tile_size.x
	var limit_bottom = map_rect.end.y * tile_size.y
	
	if camera:
		camera.limit_left = limit_left
		camera.limit_top = limit_top
		camera.limit_right = limit_right
		camera.limit_bottom = limit_bottom
	
	for c in checkpoints:
		if c.is_start_point:
			GameManager.set_checkpoint(c.global_position)

func _process(_delta: float) -> void:
	if Dialogic.VAR.get_variable("pegouMascaraCamaleao"):
		GameManager.player_ref.setCmalaeonMask(mascara)
	
	if GameManager.player_ref.yellow_collision and Dialogic.VAR.get_variable("pegouMascaraCamaleao"):
		yellow_floor.modulate.a = 1.0
		purple_floor.modulate.a = 0.8
	elif !GameManager.player_ref.yellow_collision and Dialogic.VAR.get_variable("pegouMascaraCamaleao"):
		yellow_floor.modulate.a = 0.8
		purple_floor.modulate.a = 1.0
