extends Area2D
const SPEED = 200
var direction = 1
const damage = 50
var shooter = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += direction*SPEED*delta
	await get_tree().create_timer(5).timeout.connect(queue_free)
	
	


func _on_body_entered(body: Node2D) -> void:
	if body != shooter:
		if body.has_node("HP"):
			body.get_node("HP").damage_taken(damage)
	
