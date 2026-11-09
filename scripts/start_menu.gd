extends Control
@export var audio_bus_name: String
@export var menu_buttons: VBoxContainer
@export var options: Panel
@onready var menu_buttons_container: MarginContainer = $menu_buttons/menu_buttons_container


var audio_bus_id
func ready():
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	options.visible = false
	
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Station.tscn")
	


func _on_settings_pressed() -> void:
	menu_buttons_container.visible = false
	options.visible = true
	
	


func _on_back_pressed() -> void:
	options.visible = false
	menu_buttons_container.visible = true


func _on_volume_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	#AudioServer.set_bus_volume_db(audio_bus_id,value)
	pass
	
	






func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	


func _on_option_button_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600,900))
		2:
			DisplayServer.window_set_size(Vector2i(1280,720))
