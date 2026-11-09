extends CanvasLayer
@onready var v_box_container: VBoxContainer = $ColorRect/TextureRect/VBoxContainer
@onready var v_box_container_2: VBoxContainer = $ColorRect/TextureRect/VBoxContainer2
@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"
@onready var example_balloon: CanvasLayer = $"../ExampleBalloon"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	get_tree().paused = false


func testEsc():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		get_tree().paused = true
		visible = true
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		get_tree().paused = false
		visible = false
func _process(delta: float) -> void:
	testEsc()


func _on_settings_3_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")



func _on_settings_pressed() -> void:
		get_tree().paused = false
		visible = false


func _on_settings_2_pressed() -> void:
	v_box_container.visible = false
	v_box_container_2.visible = true
	
	
	


func _on_back_pressed() -> void:
	v_box_container.visible = true
	v_box_container_2.visible = false
