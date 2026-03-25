extends RigidBody2D

@export var blackhole: PackedScene
var dir: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Throw_x = 300*dir
	var Throw_y = -250
	var Throw_dir = Vector2(Throw_x, Throw_y)
	apply_central_impulse(Throw_dir)
	await get_tree().create_timer(1).timeout
	freeze = true
	await get_tree().create_timer(0.5).timeout
	var BH = blackhole.instantiate()
	BH.global_position = global_position
	get_tree().current_scene.add_child(BH)
	queue_free()
