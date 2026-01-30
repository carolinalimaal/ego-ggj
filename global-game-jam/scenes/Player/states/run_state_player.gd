class_name RunStatePlayer
extends State

func _enter() -> void:
	pass

func _exit() -> void:
	pass

func _update(_delta: float) -> void:
	pass

func _physics_update(_delta: float) -> void:
	owner_node.horizontalMovement()
	owner_node.handleJump()
	owner_node.handleFalling()
	handleIdle()

func handleIdle():
	if (owner_node.move_direction == 0):
		transition_to("IdleState")
		return
