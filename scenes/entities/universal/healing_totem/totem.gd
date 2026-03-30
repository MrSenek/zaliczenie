extends Area2D
@onready var totem: Area2D = $"."

var HP

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func locate_healing_targets():
	var targets =  totem.get_overlapping_bodies()
	for body in targets:
		if body.is_in_group("enemy") and body.has_node("HP"):
			HP = body.get_node("HP").CURRENT_HEALTH
			pass
