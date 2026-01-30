class_name Player
extends CharacterBody2D

#region player variables

# nodes
@onready var state_machine: StateMachine = $StateMachine

# physics variables
var max_health: float = 100
var health: float = max_health
@export var speed: float = 150.0
@export var acceleration: float = 25
@export var jump_velocity: float = -175.0
const max_jumps: int = 1
var jumps: int = 0
var move_direction: float = 0
var facing: int = 1
const gravity: float = 300

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
	#getInputStates()
	
	# horizontal movement
	handleGravity(delta)
	#horizontalMovement()
	#handleJump()
	
	move_and_slide()

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



func handleGravity(delta) -> void:
	if(!is_on_floor()):
		velocity.y += gravity * delta
	else:
		jumps = 0

func handleJump():
	if (key_jump_pressed):
		if (jumps < max_jumps):
			velocity.y = jump_velocity
			jumps += 1

#endregion
