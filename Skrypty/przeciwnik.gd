extends CharacterBody2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var timer: Timer = $Timer
@onready var dziura: RayCast2D = $RayCast2D2
@onready var bullet_scena : PackedScene = preload("res://Sceny/SmallFireball.tscn")
@onready var shoot_cooldown: Timer = $shoot_cooldown
@onready var monetka : PackedScene = preload("res://Sceny/Moneta.tscn")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 75.0
const JUMP_VELOCITY = -250.0
@export var HEALTH_POINTS: int = 30
var is_dead = false

func shoot():
	if shoot_cooldown.is_stopped():
		for i in range(2):
			var add_bullet = bullet_scena.instantiate()
			add_bullet.global_position = global_position
			add_bullet.global_position.y += randi_range(-2,2)
			add_bullet.direction = direction
			add_bullet.shooter = "Enemy"
			get_tree().current_scene.add_child(add_bullet)
		shoot_cooldown.start()



func jump():
	if  is_on_floor():
		velocity.y = JUMP_VELOCITY

var direction = 1
func edge():
	if !dziura.is_colliding() and is_on_floor():
		direction *= -1
		dziura.position.x *= -1
		ray_cast_2d.target_position.x *= -1
		timer.start(randi_range(3,8))

func wandering():
	if timer.is_stopped():
		direction = (randi() % 2) * 2 - 1
		dziura.position.x = abs(dziura.position.x) * direction
		ray_cast_2d.target_position.x = abs(ray_cast_2d.target_position.x) * direction
		timer.start()
	velocity.x = direction * SPEED
	edge()
	shoot()
	if  ray_cast_2d.is_colliding():
		jump()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if !is_dead:
		wandering()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	

	move_and_slide()


func _on_hp_death() -> void:
	if is_dead:
		return
	else:
		animated_sprite_2d.play("dead")
		is_dead = true
		collision_layer = 0
		collision_layer = 0
		get_parent().current_enemies -= 1
		await get_tree().create_timer(2).timeout
		var moneta = monetka.instantiate()
		moneta.global_position = global_position
		get_tree().current_scene.add_child(moneta)
		queue_free()
