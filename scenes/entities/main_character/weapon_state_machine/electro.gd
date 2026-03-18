extends Weapon_State

class_name electro
@onready var lightning_line: Line2D = $lightning_line
@onready var collision: ShapeCast2D = $ShapeCast2D

var last_dir = 1
func enter():
	collision.enabled = false
	
func exit():
	pass

func handle_input(event: InputEvent):
	if Input.is_action_just_pressed("Weapon 1"):
		weapon_state_machine.change_state("fireball")
	if Input.is_action_just_pressed("strzal"):
		attack()
		
func update(delta: float):
	var direction := Input.get_axis("ui_left","ui_right")
	if direction:
		if direction > 0:
			last_dir = 1
		elif direction < 0:
			last_dir = -1
		

func attack():
	collision.enabled = true
	collision.max_results = 15
	collision.clear_exceptions()
	collision.add_exception(character)
	collision.force_shapecast_update()
	var target_pos = Vector2(150*last_dir,0)
	lightning_line.show()
	lightning_line.create_lightning(Vector2.ZERO, target_pos)
	
	var collision_count = collision.get_collision_count()
	print(collision_count)
	for i in range(collision_count):
		var target = collision.get_collider(i)
		if target.has_node("HP"):
			target.get_node("HP").damage_taken(50)
		elif target is TileMapLayer:
			break
	
	await get_tree().create_timer(0.1).timeout
	lightning_line.hide()
	collision.enabled = false
