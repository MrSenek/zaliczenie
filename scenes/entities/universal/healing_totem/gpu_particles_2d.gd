extends GPUParticles2D
@onready var line_2d: Line2D = $".."
@onready var mat = process_material as ParticleProcessMaterial


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var p1 = line_2d.get_point_position(0)
	var p2 = line_2d.get_point_position(1)
	
	global_position = line_2d.to_global((p1 + p2) / 2)
	var direction = p2 - p1
	rotation = direction.angle()
	mat.emission_box_extents.x = direction.length() / 2
	
	if line_2d.visible and not emitting:
		restart() 
		emitting = true
	elif not line_2d.visible:
		emitting = false
