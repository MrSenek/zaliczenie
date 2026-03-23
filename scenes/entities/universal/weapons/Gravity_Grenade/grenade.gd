extends RigidBody2D

var dir: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Throw_x = 150*dir
	var Throw_y = -250
	var Throw_dir = Vector2(Throw_x, Throw_y)
	apply_central_impulse(Throw_dir)
