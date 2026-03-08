extends CharacterBody2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var timer: Timer = $Timer
@onready var dziura: RayCast2D = $RayCast2D2


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
@export var HEALTH_POINTS: int = 30

func jump():
	if  is_on_floor():
		velocity.y = JUMP_VELOCITY

var direction = 1
func edge():
	if !dziura.is_colliding() and is_on_floor():
		direction *= -1
		dziura.position.x *= -1
		timer.start()
		print("lolo")

func wandering():
	if timer.is_stopped():
		direction = (randi() % 2) * 2 - 1
		dziura.position.x = abs(dziura.position.x) * direction
		timer.start()
	velocity.x = direction * SPEED
	edge()
	if  ray_cast_2d.is_colliding():
		jump()
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	wandering()

	move_and_slide()


func _on_hp_death() -> void:
	queue_free()
