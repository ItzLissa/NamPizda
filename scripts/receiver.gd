extends Area2D

var laser_on = false
var laser_time = 0.0
var completed = false

@export var need_time = 5.0

@export var orange_texture: Texture2D
@export var red_texture: Texture2D
@export var green_texture: Texture2D

@export_enum("Orange","Red","Green") var receiver_type: int

func _ready() -> void:
	match receiver_type:
		0:
			$Sprite2D.texture = orange_texture
		1:
			$Sprite2D.texture = red_texture
		2:
			$Sprite2D.texture = green_texture

func _process(delta: float) -> void:
	if laser_on:
		laser_time+=delta
		if laser_time>=need_time:
			laser_time=need_time
			completed=true
	else:
		laser_time = 0.0
		completed = false

func activate():
	laser_on = true
func deactivate():
	laser_on = false
