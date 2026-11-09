extends Node2D

@onready var ray = $RayCast2D
@onready var line = $Line2D

func _process(_delta):
	var exclude = []
	line.clear_points() #удаление старой линии
	var points = []
	var start = Vector2.ZERO
	var direction = ray.target_position.normalized()
	points.append(start)
	var current_position=global_position
	for i in range(25):
		var space = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(current_position,current_position+direction*1000)
		query.exclude=exclude
		query.collision_mask=1
		query.collide_with_areas = true
		var result = space.intersect_ray(query)
		if result:
			var hit_point = result.position
			points.append(to_local(hit_point))
			var collider = result.collider
			if collider.is_in_group("Mirrors"):
				var normal = result.normal.normalized()
				if direction.dot(normal)>0:
					normal = -normal
				direction=direction.bounce(normal).normalized()
				current_position = hit_point + direction.normalized() * 2
			else:
				if collider.is_in_group("Receivers"):
					points.append(to_local(hit_point))
					collider.laser_on = true
				break
		else:
			points.append(to_local(current_position+direction*1000))
			break
	for point in points:
		line.add_point(point)
