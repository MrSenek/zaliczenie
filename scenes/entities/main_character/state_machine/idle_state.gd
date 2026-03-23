extends State

class_name idle_state


	
func handle_input(event: InputEvent):
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		state_machine.change_state("walk_state")
	elif Input.is_action_just_pressed("ui_accept"):
		state_machine.change_state("jump_state")
	pass
