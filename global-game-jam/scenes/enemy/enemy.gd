class_name Enemy
extends CharacterBody2D

const SPEED: int = 50
var direction: int = 1

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight

func _physics_process(delta: float) -> void:
	if GameManager.can_move:
		if !is_on_floor():
			velocity += get_gravity() * delta
			
		if ray_cast_left.is_colliding():
			direction = 1
			sprite.flip_h = false
		if ray_cast_right.is_colliding():
			direction = -1
			sprite.flip_h = true
		
		velocity.x = direction * SPEED
	
		move_and_slide()
