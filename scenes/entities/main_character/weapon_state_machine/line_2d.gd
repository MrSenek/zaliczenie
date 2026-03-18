extends Line2D

@export var segments: int = 6        # Na ile części dzielimy piorun
@export var deviation: float = 15.0  # Jak bardzo zygzak "skacze" na boki

func _ready():
	clear_points()

func create_lightning(start_pos: Vector2, end_pos: Vector2):
	clear_points()
	add_point(start_pos)
	
	for i in range(1, segments):
		var progress = float(i) / segments
		var base_pos = start_pos.lerp(end_pos, progress)
		
		var direction = (end_pos - start_pos).normalized()
		var normal = Vector2(-direction.y, direction.x)
		var offset = normal * randf_range(-deviation, deviation)
		
		add_point(base_pos + offset)
	
	add_point(end_pos)


func _process(_delta):
	if points.size() > 0:
		create_lightning(points[0], points[points.size()-1])
