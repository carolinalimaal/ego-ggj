#class_name IdleStatePlayer
extends State

func _enter():
	pass

func _exit():
	pass
	
func _update(_delta: float) -> void:
	pass

func _physics_update(_delta: float) -> void:
	owner_node.handleFalling()
	owner_node.handleJump()
	owner_node.horizontalMovement()
	if (owner_node.move_direction != 0):
		transition_to("RunState")
		return 
