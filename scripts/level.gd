extends Node2D

@export_file("*.tscn") var change_scene

func _process(_delta: float) -> void:
	var receivers = get_tree().get_nodes_in_group("Receivers")
	for receiver in receivers:
		if not receiver.completed:
			return
	Global.level_completed=true
	get_tree().change_scene_to_file(change_scene)
