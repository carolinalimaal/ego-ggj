class_name PlayerCamera
extends Camera2D

# Referência ao player
var player: Node2D

@export var smooth_speed: float = 5.0
@export var fixed_y_position: float = 180.0 

func _ready() -> void:
	make_current()
	
	global_position.y = fixed_y_position

func _physics_process(delta: float) -> void:
	if not is_instance_valid(player):
		player = get_tree().get_first_node_in_group("Player")
		return
	var target_position = Vector2(player.global_position.x, fixed_y_position)
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * smooth_speed))
