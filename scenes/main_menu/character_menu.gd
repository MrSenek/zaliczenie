extends RigidBody2D

@export var speed: float = 400.0


func _ready() -> void:
	var screen_size = get_viewport().get_visible_rect().size
	position = Vector2(randf_range(0,screen_size.x), randf_range(0, screen_size.y))
	var dir = randf_range(-1,1)
	var direction = Vector2(dir, dir).normalized()
	apply_central_impulse(direction * speed)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if state.linear_velocity.length() > 0:
		state.linear_velocity = state.linear_velocity.normalized() * speed
