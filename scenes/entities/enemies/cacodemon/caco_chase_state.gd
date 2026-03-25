extends Enemy_State

class_name caco_chase_state
@onready var nav_agent: NavigationAgent2D = $"../../NavigationAgent2D"
@onready var ray_cast_2d: RayCast2D = $"../../eyes/RayCast2D"

var last_loc : Vector2

func enter():
	update_last_position()

func physics_update(delta: float):
	nav_agent.target_position = last_loc
	var next_path_pos = nav_agent.get_next_path_position()
	var new_velocity = (next_path_pos - character.global_position).normalized() * 100
	character.velocity = new_velocity
	character.move_and_slide()
	if nav_agent.is_target_reached():
		character.velocity = Vector2.ZERO
		enemy_state_machine.change_state("caco_idle_state")


func update_last_position():
	if ray_cast_2d.is_colliding():
		last_loc = ray_cast_2d.get_collision_point()
