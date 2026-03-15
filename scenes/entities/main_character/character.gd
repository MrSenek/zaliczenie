extends CharacterBody2D
@onready var bullet_scena : PackedScene = preload("res://scenes/entities/universal/weapons/fireball.tscn")
@onready var sprite_2d: Sprite2D = $Sprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var stats: Stats
@onready var HEALTH_POINTS: int = stats.max_health
var SPAWN_POINT


#zmienne pocisku
var last_dir = 1
var can_shoot = true
#strzelanie
func shoot():
	var dir = Input.get_axis("ui_left","ui_right")
	if dir != 0:
		last_dir = dir
	if Input.is_action_just_pressed("strzal") and can_shoot:
		var add_bullet = bullet_scena.instantiate()
		var cooldown_shoot = add_bullet.cooldown
		add_bullet.global_position = global_position
		add_bullet.direction = last_dir
		add_bullet.shooter = "Player"
		add_bullet.damage *= stats.attack
		get_tree().current_scene.add_child(add_bullet)
		can_shoot = false
		await get_tree().create_timer(cooldown_shoot).timeout
		can_shoot = true

func _ready() -> void:
	SPAWN_POINT = global_position
	self.add_to_group("Player")
	
	
func _physics_process(delta: float) -> void:
	shoot()
	
func _on_hp_death() -> void:
		global_position = SPAWN_POINT
		get_node("HP").CURRENT_HEALTH = HEALTH_POINTS
		get_node("HP").set_health(HEALTH_POINTS)
