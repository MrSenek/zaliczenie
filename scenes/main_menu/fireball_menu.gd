extends RigidBody2D

@export var speed: float = 400.0

func _ready() -> void:
	var direction = Vector2(-1, 1).normalized()
	apply_central_impulse(direction * speed)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if state.linear_velocity.length() > 0:
		state.linear_velocity = state.linear_velocity.normalized() * speed
