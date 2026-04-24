extends Enemy_State
@onready var sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var attack_range: Area2D = $"../../detection/Attack_Range"


func enter(data = {}):
	sprite.flip_h = !sprite.flip_h
	await get_tree().create_timer(0.7).timeout
	sprite.flip_h = !sprite.flip_h
	await get_tree().create_timer(0.7).timeout
	sprite.flip_h = !sprite.flip_h
	await get_tree().create_timer(0.7).timeout
	enemy_state_machine.change_state("caco_idle_state")


func update(delta: float):
	var targets = character.seeing_range.get_overlapping_bodies()
	var attack_targets = attack_range.get_overlapping_bodies()
	for body in attack_targets:
		if body.is_in_group("Player"):
			enemy_state_machine.change_state("caco_attack_state")
			return
	for body in targets:
		if body.is_in_group("Player"):
			character.eyes.look_at(body.global_position)
			if character.ray_cast_2d.is_colliding() and character.ray_cast_2d.get_collider().is_in_group("Player"):
				enemy_state_machine.change_state("caco_chase_state")
				return
