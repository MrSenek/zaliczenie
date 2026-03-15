extends Area2D
const heal = 50


func _on_body_entered(body: Node2D) -> void:
	if body.has_node("HP"):
		body.get_node("HP").get_hp(heal)
