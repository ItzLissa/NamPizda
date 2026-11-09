extends Area2D

@onready var prompt: Label = $Label
@export_file("*.tscn") var station_scene: String

var player_near := false

func _ready() -> void:
	prompt.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_near = true
		prompt.visible = true

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_near = false
		prompt.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if player_near and event.is_action_pressed("interact"):
		_sleep()

func _sleep() -> void:
	if not Global.level_completed:
		prompt.text = "Сначала выполни задание!"
		await get_tree().create_timer(2.0).timeout
		prompt.text = "[E] Спать"
		return

	Global.day += 1
	Global.level_completed = false

	if station_scene:
		get_tree().change_scene_to_file(station_scene)
	else:
		get_tree().reload_current_scene()
