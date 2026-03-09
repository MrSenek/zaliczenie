extends Area2D
const SPEED = 200
var direction = 1
const damage = 50
var shooter = null

func _ready() -> void:
	get_tree().create_timer(5.0).timeout.connect(queue_free)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += direction*SPEED*delta

func _on_body_entered(body: Node2D) -> void:
	if body != shooter:
		if body.has_node("HP"):
			body.get_node("HP").damage_taken(damage)
	
