extends Node2D
@onready var area_2d: Area2D = $Area2D
@onready var damage_cooldown: Timer = $damage_cooldown
@onready var smoke_timer: Timer = $smoke_timer



func _process(delta: float) -> void:
	var targets = area_2d.get_overlapping_bodies()
	for body in targets:
		if body.is_in_group("Player") and body.has_node("HP") and damage_cooldown.is_stopped():
			body.get_node("HP").damage_taken(5)
			damage_cooldown.start()
		if body.has_method("change_speed"):
			body.change_speed(0.75)
	if smoke_timer.is_stopped():
		queue_free()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("change_speed"):
		body.change_speed(1.0)
