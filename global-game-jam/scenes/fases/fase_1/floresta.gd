extends Node2D

@onready var world_floor: TileMapLayer = $TileLayers/Floor
@onready var camera: PlayerCamera = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var map_limits = world_floor.get_used_rect()
	var map_cellsize = world_floor.tile_set.tile_size
	camera.limit_left = map_limits.position.x * map_cellsize.x
	camera.limit_top = map_limits.position.y * map_cellsize.y
	camera.limit_right = map_limits.end.x * map_cellsize.x
	camera.limit_bottom = map_limits.end.y * map_cellsize.y
