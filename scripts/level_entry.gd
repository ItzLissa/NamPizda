extends Area2D

@export_file("*.tscn") var target_scene: String  # путь к сцене уровня
@onready var menu: Panel = $CanvasLayer/Panel

var player_inside := false

func _ready() -> void:
	menu.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	$CanvasLayer/Panel/YesButton.pressed.connect(_on_yes)
	$CanvasLayer/Panel/NoButton.pressed.connect(_on_no)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_inside = true
		menu.visible = true  # показываем меню при входе

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_inside = false
		menu.visible = false

func _on_yes() -> void:
	if target_scene:
		get_tree().change_scene_to_file(target_scene)
	else:
		push_error("Не указана сцена уровня!")

func _on_no() -> void:
	menu.visible = false
	# Если игрок всё ещё в зоне, можно снова показать меню позже,
	# но для простоты просто скрываем до выхода и повторного входа.
