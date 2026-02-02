class_name NPC
extends CharacterBody2D

@export var npc_name: String
@export var dialogue_timeline: String
@export var original_collision: Shape2D
@export var second_collision: Shape2D

var can_talk: bool = false
var is_talking: bool = false

@onready var interact_area: Area2D = $InteractArea
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var collision: CollisionShape2D = $Collision

func _ready() -> void:
	interact_area.body_entered.connect(_on_interact_area_entered)
	interact_area.body_exited.connect(_on_interact_area_exited)
	
	Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)
	
	if !Dialogic.VAR.get_variable("pegouMascaraCamaleao") or !Dialogic.VAR.get_variable("pegouMascaraMorcego"):
		collision.shape = original_collision
		sprite.play("default")
	else:
		collision.shape = second_collision
		sprite.play("pos_mascara")


func _physics_process(delta: float) -> void:
	if !is_on_floor() and npc_name == "Camaleao":
		velocity += get_gravity() * delta
	if npc_name == "Morcego" and Dialogic.VAR.get_variable("pegouMascaraMorcego"):
		if !is_on_floor():
			velocity += get_gravity() * delta
	move_and_slide()

func _unhandled_input(_event: InputEvent) -> void:
	if can_talk and Input.is_action_just_pressed("dialogic_default_action"):
		if !is_talking:
			is_talking = true
			Dialogic.start(dialogue_timeline)
			Dialogic.timeline_started.emit()

func _on_interact_area_entered(body: Node2D) -> void:
	if body is Player:
		can_talk = true

func _on_interact_area_exited(body: Node2D) -> void:
	if body is Player:
		can_talk = false

func _on_dialogic_timeline_ended() -> void:
	is_talking = false
	if npc_name == "Camaleao" and Dialogic.VAR.get_variable("pegouMascaraCamaleao"):
		collision.shape = second_collision
		sprite.play("pos_mascara")
	if npc_name == "Morcego" and Dialogic.VAR.get_variable("pegouMascaraMorcego"):
		collision.shape = second_collision
		sprite.play("pos_mascara")
