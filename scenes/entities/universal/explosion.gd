extends Area2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	gpu_particles_2d.emitting = true

func _on_body_entered(body: Node2D) -> void:
	if body.has_node("HP"):
		body.get_node("HP").damage_taken(150)
