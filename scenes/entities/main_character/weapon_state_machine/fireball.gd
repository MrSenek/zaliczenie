extends Weapon_State
class_name fireball


@onready var sprite_2d: Sprite2D = $Sprite2D

func enter():
	if not is_node_ready():
		await tree_entered
	sprite_2d.show()

func exit():
	sprite_2d.hide()

func update(_delta):
	if character.sprite_2d.flip_h:
		sprite_2d.position.x = 15
		sprite_2d.flip_h = true
		
	else:
		sprite_2d.position.x = -15
		sprite_2d.flip_h = false
		sprite_2d.rotation = (PI / 2)
