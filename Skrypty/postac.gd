extends CharacterBody2D
@onready var bullet_scena : PackedScene = preload("res://Sceny/bullet.tscn")
@onready var sprite_2d: Sprite2D = $Sprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var HEALTH_POINTS: int = 100
var SPAWN_POINT
#skakanie
var has_jumped = false
func jump():
	if is_on_floor():
		has_jumped = false
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	elif Input.is_action_just_pressed("ui_accept") and has_jumped == false:
		velocity.y = JUMP_VELOCITY*0.8
		has_jumped = true



#zmienne pocisku
var last_dir = 1
var can_shoot = true
var cooldown_shoot = 1
#strzelanie
func shoot():
	var dir = Input.get_axis("ui_left","ui_right")
	if dir != 0:
		last_dir = dir
	if Input.is_action_just_pressed("strzal") and can_shoot:
		var add_bullet = bullet_scena.instantiate()
		add_bullet.global_position = global_position
		add_bullet.direction = last_dir
		add_bullet.shooter = "Player"
		get_tree().current_scene.add_child(add_bullet)
		can_shoot = false
		await get_tree().create_timer(cooldown_shoot).timeout
		can_shoot = true

func _ready() -> void:
	SPAWN_POINT = global_position
	self.add_to_group("Player")

func _process(_delta: float) -> void:
	pass
	

func _physics_process(delta: float) -> void:
	#shoot
	shoot()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	jump()
	var direction := Input.get_axis("ui_left", "ui_right")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if direction < 0:
		sprite_2d.flip_h = true
	elif direction > 0:
		sprite_2d.flip_h = false
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_hp_death() -> void:
		global_position = SPAWN_POINT
		get_node("HP").CURRENT_HEALTH = HEALTH_POINTS
		get_node("HP").set_health(HEALTH_POINTS)
