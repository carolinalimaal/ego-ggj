class_name NPC
extends CharacterBody2D

@export var dialogue_timeline: String

var can_talk: bool = false
var is_talking: bool = false

@onready var interact_area: Area2D = $InteractArea

func _ready() -> void:
	interact_area.body_entered.connect(_on_interact_area_entered)
	interact_area.body_exited.connect(_on_interact_area_exited)
	
	Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)


func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()

func _unhandled_input(_event: InputEvent) -> void:
	if can_talk and Input.is_action_just_pressed("dialogic_default_action"):
		if !is_talking:
			is_talking = true
			Dialogic.start(dialogue_timeline)
		

func _on_interact_area_entered(body: Node2D) -> void:
	if body is Player:
		can_talk = true

func _on_interact_area_exited(body: Node2D) -> void:
	if body is Player:
		can_talk = false

func _on_dialogic_timeline_ended() -> void:
	is_talking = false
