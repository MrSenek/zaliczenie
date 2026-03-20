extends Area2D
var closest_enemy


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	closest_enemy = find_enemy()
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func find_enemy():
	var enemies = get_tree().get_nodes_in_group("enemy")
	var closest_distance = INF
	var closest
	
	for enemy in enemies:
		var dist = global_position.distance_to(enemy)
		
		if dist < closest_distance:
			closest_distance = dist
			closest = enemy
	return closest
		
func chase_enemy():
	pass
	
