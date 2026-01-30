class_name Player
extends CharacterBody2D

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
const gravity_jump: float = 700
const gravity_fall: float = 1000
const jump_multiplier: float = 0.5

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

func _physics_process(_delta: float) -> void:
	# getting inputs
	getInputStates()
	
	# horizontal movement
	move_and_slide()
	handleAnimation()

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
	if(!is_on_floor()):
		velocity.y += gravity * delta

func handleFalling() -> void:
	if (!is_on_floor()):
		state_machine.current_state.transition_to("FallState")
	
func handleLanding() -> void:
	if (is_on_floor()):
		jumps = 0
		state_machine.current_state.transition_to("IdleState")

func handleJump() -> void:
	if (key_jump_pressed) and (jumps < max_jumps):
		jumps += 1
		sprite.play("jump_animation")
		state_machine.current_state.transition_to("JumpState")
		

func horizontalMovement() -> void:
	move_direction = Input.get_axis("Left", "Right")
	if (move_direction != 0):
		velocity.x = move_toward(velocity.x , move_direction * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x , move_direction * speed, desacceleration)

func handleAnimation() -> void:
	sprite.flip_h = (facing < 0)
	
	if (is_on_floor()):
		if (velocity.x != 0):
			sprite.play("run_animation")
		else:
			sprite.play("idle_animation")
	else:
		if(velocity.y < 0 and sprite.animation != "jump_animation"):
			sprite.play("jump_animation")
		elif (velocity.y >= 0):
			sprite.animation = "jump_animation"
			sprite.frame = 3

#endregion
