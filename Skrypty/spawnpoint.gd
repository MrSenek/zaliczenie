extends Node2D
@onready var enemy_scene : PackedScene = preload("res://Sceny/Przeciwnik.tscn")
@export var player: Node2D	
@onready var timer: Timer = $Timer
var current_enemies : int;

func spawn_enemy():
	var player_location = player.global_position
	var distance_to_player = player_location.x - global_position.x
	if abs(distance_to_player) > 100 and timer.is_stopped() and current_enemies <= 1:
		timer.start(5)
		var create_enemy = enemy_scene.instantiate()
		add_child(create_enemy)
		create_enemy.add_to_group("Enemy")
		current_enemies += 1
		
		




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_enemy()
