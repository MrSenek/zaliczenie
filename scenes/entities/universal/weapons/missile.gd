extends Area2D
var closest_enemy = null
var speed = 300
var shooter
@export var explosion: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	closest_enemy = find_enemy()
	print(closest_enemy)




func _physics_process(delta: float) -> void:
	if closest_enemy == null:
		queue_free()
	chase_enemy(delta)



func find_enemy():
	var enemies = get_tree().get_nodes_in_group("enemy")
	var closest_distance = INF
	var closest
	
	for enemy in enemies:
		if not enemy:
			return
		var dist = global_position.distance_to(enemy.global_position)
		
		if dist < closest_distance:
			closest_distance = dist
			closest = enemy
	return closest
		
func chase_enemy(delta: float):
	if closest_enemy == null:
		return
	var direction = (closest_enemy.global_position - global_position).normalized()
	global_position += speed*direction*delta
	rotation = direction.angle()



func _on_body_entered(body: Node2D) -> void:
	print(body)
	if not body.is_in_group(shooter):
		if body.has_node("HP"):
			body.get_node("HP").damage_taken(10000)
			queue_free()
		var explode = explosion.instantiate()
		explode.global_position = body.global_position
		get_tree().current_scene.add_child(explode)
