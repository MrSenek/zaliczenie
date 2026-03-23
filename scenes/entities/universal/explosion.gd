extends Area2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	monitoring = true
	gpu_particles_2d.emitting = true
	await get_tree().physics_frame
	var bodies = get_overlapping_bodies()
	for body in bodies:
		print(body)
		if body.has_node("HP"):
			body.get_node("HP").damage_taken(50)
	get_tree().create_timer(1.0).timeout.connect(queue_free)
