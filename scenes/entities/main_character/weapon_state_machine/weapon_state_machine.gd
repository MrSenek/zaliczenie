extends Node

class_name Weapon_State_Machine

@export var initial_state: Weapon_State

var current_state : Weapon_State
var states: Dictionary = {}


func _ready() -> void:
	
	#Register all child states
	for child in get_children():
		states[child.name.to_lower()] = child
		child.weapon_state_machine = self
		child.character = get_parent()
		if child.character.has_node("StateMachine"):
			child.state_machine = child.character.get_node("StateMachine")
		
	
	#Start with initial state
	if initial_state:
		change_state(initial_state.name.to_lower())
	

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
	
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)
	
	if event.is_action_pressed("Weapon 1"):
		change_state("fireball")
	elif event.is_action_pressed("Weapon 2"):
		change_state("electro")
	
func change_state(new_state_name: String) -> void:
	if current_state:
		current_state.exit()

	current_state = states.get(new_state_name.to_lower())

	if current_state:
		current_state.enter()


	
