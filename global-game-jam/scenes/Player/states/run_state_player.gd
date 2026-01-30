class_name RunStatePlayer
extends State

func _enter() -> void:
	pass

func _exit() -> void:
	pass

func _update(_delta: float) -> void:
	pass

func _physics_update(_delta: float) -> void:
	owner_node.move_direction = Input.get_axis("Left", "Right")
	if not owner_node.move_direction: #talvez colocar == 0?
		transition_to("IdleState")
		return
	owner_node.velocity.x = move_toward(owner_node.velocity.x , owner_node.move_direction * owner_node.speed, owner_node.acceleration)

#func horizontalMovement() -> void:
	#owner_node.move_direction = Input.get_axis("Left", "Right")
	#owner_node.velocity.x = move_toward(owner_node.velocity.x , owner_node.move_direction * owner_node.speed, owner_node.acceleration)
