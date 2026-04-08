extends GPUParticles2D
@onready var line_2d: Line2D = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	emitting = line_2d.visible
	position = line_2d.get_point_position(1)
