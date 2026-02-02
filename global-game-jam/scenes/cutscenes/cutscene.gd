extends Control

@export var cutscene_name: String
@export var frames_cutscene: Array[Texture2D]
@export var frame: TextureRect
@export_file("*.tscn") var next_scene_path: String
@export var sfx: AudioStreamPlayer

var can_play: bool = true
var count: int = 0
var is_transitioning: bool = false
var transition_duration: float = 0.5

func _ready() -> void:
	frame.modulate.a = 0.0
	
	if frames_cutscene.size() > 0:
		frame.texture = frames_cutscene[count]
		_animate_fade_in()

func _process(_delta: float) -> void:
	if cutscene_name == "Prisma1" and count == 1 and !sfx.playing and can_play:
		can_play = false
		sfx.play()
	if cutscene_name == "Prisma2" and count == 1 and !sfx.playing and can_play:
		can_play = false
		sfx.play()

func _unhandled_input(_event: InputEvent) -> void:
	if is_transitioning:
		return
	
	if Input.is_action_just_pressed("dialogic_default_action"):
		count += 1
		if count < frames_cutscene.size():
			_play_animation_effect()
		else:
			_end_cutscene()

func _play_animation_effect() -> void:
	var tween = create_tween()
	
	tween.tween_property(frame, "modulate:a", 0.0, transition_duration/2)
	
	tween.tween_callback(
		func(): frame.texture = frames_cutscene[count]
	)
	
	tween.tween_property(frame, "modulate:a", 1.0, transition_duration/2)
	
	tween.finished.connect(
		func(): is_transitioning = false
	)
	
func _animate_fade_in() -> void:
	var tween = create_tween()
	tween.tween_property(frame, "modulate:a", 1.0, transition_duration)
	
func _end_cutscene() -> void:
	var tween = create_tween()
	tween.tween_property(frame, "modulate:a", 0.0, transition_duration)
	tween.finished.connect(
		func (): GameManager.change_level(next_scene_path)
	)
	
