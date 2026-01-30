class_name IdleStatePlayer
extends State

func _enter():
	owner_node.velocity = Vector2.ZERO

func _exti():
	pass
	
func _update(_delta: float) -> void:
	pass

func _physics_update(_delta: float) -> void:
	owner_node.move_direction = Input.get_axis("Left", "Right")
	if owner_node.move_direction: #talvez colocar != 0?
		transition_to("RunState")
		return
	
