#class_name JumpStatePlayer
extends State

func _enter() -> void:
	if (owner_node.is_on_ceiling()):
		owner_node.velocity.y = -owner_node.jump_velocity
	else:
		owner_node.velocity.y = owner_node.jump_velocity
	

func _exit() -> void:
	pass

func _update(_delta: float) -> void:
	pass

func _physics_update(_delta: float) -> void:
	owner_node.horizontalMovement()
	handleJumpToFall()
	

func handleJumpToFall():
	if !owner_node.key_jump:
		owner_node.velocity.y *= owner_node.jump_multiplier
		transition_to("FallState")
		return
