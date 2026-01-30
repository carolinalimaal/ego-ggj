class_name FallStatePlayer
extends State

func _enter() -> void:
	pass

func _exit() -> void:
	pass

func _update(_delta: float) -> void:
	pass

func _physics_update(delta: float) -> void:
	owner_node.handleGravity(delta)
	owner_node.horizontalMovement()
	owner_node.handleLanding()
