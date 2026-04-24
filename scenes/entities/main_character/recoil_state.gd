extends State
@onready var recoil: Timer = $recoil
const GHOST = preload("uid://cdo3m08l7wcjj")


var char_dir: int
var base_recoil = 1

func enter(data = {}):
	print("recoiled")
	var recoil_strength = data.get("strength", base_recoil)
	char_dir = character.dir
	character.velocity.x = char_dir*recoil_strength*-1
	recoil.start()
	character.sprite_2d.material.set_shader_parameter("blur_amount", 2.0)
	

func exit():
	recoil.stop()
	print("leaving recoil")
	character.sprite_2d.material.set_shader_parameter("blur_amount", 0.0)

func physics_update(delta: float):
	if not character.is_on_floor():
		character.velocity += character.get_gravity() * delta
	if Input.is_action_just_pressed("ui_accept"):
		
		state_machine.change_state("jump_state")
	if abs(character.velocity.x) > 100:
		spawn_ghost()
	character.move_and_slide()
	

func _on_recoil_timeout() -> void:
	state_machine.change_state("idle_state")

func spawn_ghost():
	var ghost = GHOST.instantiate()
	ghost.texture = character.sprite_2d.texture
	ghost.global_position = character.global_position
	ghost.flip_h = character.sprite_2d.flip_h
	ghost.scale = character.sprite_2d.scale
	get_tree().current_scene.add_child(ghost)
