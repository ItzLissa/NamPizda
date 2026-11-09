extends Node2D

@export var shadow_length: int

func is_player_in_shadow(player):

	var space = get_world_2d().direct_space_state

	var query = PhysicsRayQueryParameters2D.create(global_position,player.global_position)
	query.exclude = [player.get_rid()]
	query.collision_mask = 4
	var result = space.intersect_ray(query)
	if result:
		var collider = result.collider
		if collider.is_in_group("ShadowObjects"):
			var shadow_distance = global_position.distance_to(result.position)
			var player_distance = global_position.distance_to(player.global_position)
			if player_distance - shadow_distance < shadow_length:
				return true
		else:
			return false
	else:
		return false
