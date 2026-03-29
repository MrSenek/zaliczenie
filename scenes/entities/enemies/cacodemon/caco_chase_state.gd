extends Enemy_State

class_name caco_chase_state
@onready var nav_agent: NavigationAgent2D = $"../../NavigationAgent2D"
@onready var ray_cast_2d: RayCast2D = $"../../eyes/RayCast2D"
@onready var sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var seeing_range: Area2D = $"../../detection/Seeing_Range"
@onready var attack_range: Area2D = $"../../detection/Attack_Range"


var last_loc : Vector2

func enter():
	print("going to chase")
	update_last_position()

func physics_update(delta: float):
	update_last_position()
	chase()
	character.move_and_slide()
	if nav_agent.is_target_reached() and not is_player_visible():
		character.velocity = Vector2.ZERO
		enemy_state_machine.change_state("caco_search_state")

func update(delta: float):
	var targets = seeing_range.get_overlapping_bodies()
	
	var attack_targets = attack_range.get_overlapping_bodies()
	for body in attack_targets:
		if body.is_in_group("Player"):
			enemy_state_machine.change_state("caco_attack_state")
			return
	
	for body in targets:
		if body.is_in_group("Player"):
			character.eyes.look_at(body.global_position)
			break

func update_last_position():
	if ray_cast_2d.is_colliding():
		last_loc = ray_cast_2d.get_collision_point()
		

func is_player_visible():
	if ray_cast_2d.is_colliding():
		if ray_cast_2d.get_collider().is_in_group("Player"):
			return true
		else:
			return false
		
func chase():
	nav_agent.target_position = last_loc
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = character.global_position.direction_to(next_path_pos)
	character.velocity = character.velocity.move_toward(direction*125, 500*get_process_delta_time())
	
