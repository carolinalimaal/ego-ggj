class_name JumpStatePlayer
extends State

func _enter() -> void:
	owner_node.velocity.y = owner_node.jump_velocity

func _exit() -> void:
	pass

func _update(_delta: float) -> void:
	pass

func _physics_update(delta: float) -> void:
	owner_node.handleGravity(delta)
	owner_node.horizontalMovement()
	handleJumpToFall()

func handleJumpToFall():
	if (owner_node.velocity.y >= 0):
		transition_to("JumpPeakState")
