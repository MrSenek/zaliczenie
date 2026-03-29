extends CharacterBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var stats: Stats
@onready var HEALTH_POINTS: int = stats.max_health
var SPAWN_POINT
var dir
var speed_modifier: float = 1.0

func _ready() -> void:
	SPAWN_POINT = global_position
	self.add_to_group("Player")

func _process(delta: float) -> void:
	if Input.get_axis("ui_left","ui_right") != 0:
		dir = Input.get_axis("ui_left", "ui_right")

func _on_hp_death() -> void:
		global_position = SPAWN_POINT
		get_node("HP").CURRENT_HEALTH = HEALTH_POINTS
		get_node("HP").set_health(HEALTH_POINTS)

func change_speed(new: float):
	speed_modifier = new
