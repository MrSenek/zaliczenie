extends Node2D
@onready var enemy_scene : PackedScene = preload("res://Sceny/Przeciwnik.tscn")
@export var player: Node2D	
@onready var timer: Timer = $Timer

func spawn_enemy():
	var player_location = player.global_position
	var distance_to_player = player_location.x - global_position.x
	if distance_to_player > 200 and timer.is_stopped():
		var create_enemy = enemy_scene.instantiate()
		add_child(create_enemy)
		timer.start(5)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_enemy()
