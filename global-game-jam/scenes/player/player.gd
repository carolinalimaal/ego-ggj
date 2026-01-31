class_name Player
extends CharacterBody2D

signal player_died

#region player variables

# nodes
@onready var state_machine: StateMachine = $StateMachine
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# physics variables
var max_health: float = 100
var health: float = max_health
@export var speed: float = 125.0
@export var acceleration: float = 20
@export var desacceleration: float = 25
@export var jump_velocity: float = -300.0
const max_jumps: int = 1
var jumps: int = 0
var move_direction: float = 0
var facing: int = 1
@export var gravity_jump: float = 700
@export var gravity_fall: float = 1000
const jump_multiplier: float = 0.5

# masks variables
enum Mascaras {NENHUMA, CAMALEON, BAT}
var camaleon_mask: Masks = load("res://masks/resources/camaleon_mask.tres")
var bat_mask: Masks = load("res://masks/resources/bat_maks.tres")
var mask_active = Mascaras.NENHUMA
var can_change_plataform_colision: bool = false
var can_invert_gravity: bool = false
var anti_gravity: bool = false

# input variables
var key_up: bool = false
var key_down: bool = false
var key_left: bool = false
var key_right: bool = false
var key_jump: bool = false
var key_jump_pressed: bool = false

#endregion

#region main functions

func _ready() -> void:
	GlobalRefs.player = self
	
	state_machine.init(self)
	
	self.add_to_group("Player")
	

func _physics_process(delta: float) -> void:
	# getting inputs
	getInputStates()
	
	# horizontal movement
	handleGravity(delta)
	move_and_slide()
	handleAnimation()
	handleMaskActivation()
	
	

#endregion

#region custom functions

func getInputStates() -> void:
	key_up = Input.is_action_pressed("Up")
	key_down = Input.is_action_pressed("Down")
	key_left = Input.is_action_pressed("Left")
	key_right = Input.is_action_pressed("Right")
	key_jump = Input.is_action_pressed("Jump")
	key_jump_pressed = Input.is_action_just_pressed("Jump")
	
	if (key_left): facing = -1
	if (key_right): facing = 1



func handleGravity(delta, gravity: float = gravity_jump) -> void:
	if !anti_gravity:
		velocity.y += gravity * delta
	else:
		velocity.y -= gravity * delta

func handleFalling() -> void:
	if anti_gravity:
		if (!is_on_ceiling()):
			state_machine.current_state.transition_to("FallState")
	else:
		if (!is_on_floor()):
			state_machine.current_state.transition_to("FallState")
	
func handleLanding() -> void:
	if (is_on_floor() or is_on_ceiling()):
		jumps = 0
		state_machine.current_state.transition_to("IdleState")

func handleJump() -> void:
	if (key_jump_pressed) and (jumps < max_jumps) and GameManager.can_move:
		if (can_change_plataform_colision):
			changePlataformColision()
		jumps += 1
		sprite.play("jump_animation")
		state_machine.current_state.transition_to("JumpState")
		
		

func horizontalMovement() -> void:
	if GameManager.can_move:
		move_direction = Input.get_axis("Left", "Right")
		if (move_direction != 0):
			velocity.x = move_toward(velocity.x , move_direction * speed, acceleration)
		else:
			velocity.x = move_toward(velocity.x , move_direction * speed, desacceleration)

func handleAnimation() -> void:
	sprite.flip_h = (facing < 0)
	
	if (is_on_floor() or is_on_ceiling()):
		if (velocity.x != 0):
			sprite.play("run_animation")
		else:
			sprite.play("idle_animation")
	else:
		if !anti_gravity:
			if(velocity.y < 0 and sprite.animation != "jump_animation"):
				sprite.play("jump_animation")
			elif (velocity.y >= 0):
				sprite.animation = "jump_animation"
				sprite.frame = 3
		else:
			if(velocity.y > 0 and sprite.animation != "jump_animation"):
				sprite.play("jump_animation")
			elif (velocity.y <= 0):
				sprite.animation = "jump_animation"
				sprite.frame = 3

func changePlataformColision() -> void:
	if (!get_collision_mask_value(5) and !get_collision_mask_value(6)):
		set_collision_mask_value(5, true)
		return
	if (get_collision_mask_value(5)):
		set_collision_mask_value(6, true)
		set_collision_mask_value(5, false)
		return
	if (get_collision_mask_value(6)):
		set_collision_mask_value(6, false)
		set_collision_mask_value(5, true)
		return 

func handleMaskActivation() -> void:
	pass

func setCmalaeonMask(mask: Masks):
	camaleon_mask = mask

func setBatMask(mask: Masks):
	bat_mask = mask

#endregion


func _on_anti_gravity_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and !anti_gravity:
		if can_invert_gravity:
			anti_gravity = true
			sprite.flip_v = true
	elif body.is_in_group("Player") and anti_gravity:
		if can_invert_gravity:
			anti_gravity = false
			sprite.flip_v = false
