extends Area2D

@export var pull_strength := 1200.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	monitoring = true
	gravity_space_override = Area2D.SPACE_OVERRIDE_COMBINE
	gravity_point = true
	gravity_point_unit_distance = 100
	gravity = 1000
	
	await get_tree().create_timer(3).timeout
	queue_free()


func _physics_process(delta):
	for body in get_overlapping_bodies():
		if body.is_in_group("enemy") and body.has_method("add_external_force"):

			var dir = global_position - body.global_position
			var dist = dir.length()

			if dist < 10:
				continue

			var strength = pull_strength / max(dist, 50)
			var force = dir.normalized() * strength * delta

			body.add_external_force(force)

			# 🔥 tłumienie żeby nie uciekał
			if body is CharacterBody2D:
				body.velocity = body.velocity.limit_length(250)
