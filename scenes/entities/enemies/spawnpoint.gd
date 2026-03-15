extends Node2D
@onready var enemy_scene : PackedScene = preload("res://scenes/entities/enemies/small_skeleton/small_skeleton.tscn")
var player: Node2D
@onready var timer: Timer = $Timer
var current_enemies : int;

func spawn_enemy():
	var player_location = player.global_position
	var distance_to_player = player_location.x - global_position.x
	if abs(distance_to_player) > 50 and timer.is_stopped() and current_enemies <= 1:
		
		var create_enemy = enemy_scene.instantiate()
		add_child(create_enemy)
		create_enemy.add_to_group("Enemy")
		current_enemies += 1
	timer.start(5)
		

func _ready() -> void:
	player = get_tree().root.find_child("main_character", true, false)

func _on_timer_timeout() -> void:
	spawn_enemy()
	

func _process(_delta: float) -> void:
	pass
