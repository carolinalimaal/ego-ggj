class_name JumpPeakStatePlayer
extends State

func _enter() -> void:
	pass

func _exit() -> void:
	pass

func _update(_delta: float) -> void:
	pass

func _physics_update(_delta: float) -> void:
	transition_to("FallState")
	
