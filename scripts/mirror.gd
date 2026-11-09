extends StaticBody2D

@export var movable = false

@export var move_axis = Vector2.UP
@export var move_limit=100
@export var move_speed=150

var start_position
var player_near = false

func _ready():
	start_position = position

func _process(delta):
	if not movable:
		return
	if not player_near:
		return
	if Input.is_action_pressed("right-down"):
		position+=move_axis*move_speed*delta
	if Input.is_action_pressed("left-up"):
		position-=move_axis*move_speed*delta
	var offset = position - start_position
	var distance = offset.dot(move_axis)
	distance = clamp(distance,-move_limit,move_limit)
	position = start_position + move_axis * distance

func _on_interaction_area_body_entered(body):
	if body.name == "Player":
		player_near = true

func _on_interaction_area_body_exited(body):
	if body.name == "Player":
		player_near = false

func get_mirror_normal(direction: Vector2) -> Vector2:
	var mirror_direction = Vector2.RIGHT.rotated(global_rotation)
	var normal = Vector2(-mirror_direction.y, mirror_direction.x)
	if direction.dot(normal) > 0:
		normal = -normal
	return normal.normalized()
