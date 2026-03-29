extends Area2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@export var gas: PackedScene

var direction: Vector2 = Vector2.RIGHT
var SPEED = 300

func _physics_process(delta: float) -> void:
	global_position += direction * SPEED * delta

func _process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		var toxic_cloud = gas.instantiate()
		toxic_cloud.global_position = global_position
		get_tree().current_scene.add_child(toxic_cloud)
		await get_tree().create_timer(0.1).timeout
		queue_free()
