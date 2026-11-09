extends Area2D

@export_file("*.tscn") var change_scene

var laser_on = false
var laser_time = 0.0

func _process(delta: float) -> void:
	if laser_on:
		laser_time+=delta
		if laser_time>=5.0:
			Global.level_completed = true
			get_tree().change_scene_to_file(change_scene)
	else:
		laser_time = 0.0
	laser_on = false
