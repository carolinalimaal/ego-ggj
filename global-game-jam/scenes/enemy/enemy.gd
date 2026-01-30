class_name Enemy
extends CharacterBody2D

const SPEED: int = 50
var direction: int = 1

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var hitbox: Area2D = $Hitbox
@onready var hurtbox: Area2D = $Hurtbox
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight

func _ready() -> void:
	hitbox.body_entered.connect(_on_player_hitbox_entered)
	hurtbox.body_entered.connect(_on_player_hurtbox_entered)

func _physics_process(delta: float) -> void:
	
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

func _on_player_hitbox_entered(body: Node2D):
	if body is Player:
		print("player morreu")
		body.health = 0
		body.queue_free()

func _on_player_hurtbox_entered(body: Node2D):
	if body is Player:
		print("inimigo morreu")
		queue_free()
