extends Weapon_State
class_name fireball

@onready var bullet_scena : PackedScene = preload("res://scenes/entities/universal/weapons/fireball.tscn")
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
		sprite_2d.flip_h = false
		sprite_2d.rotation = (-PI / 2)

	else:
		sprite_2d.position.x = -15
		sprite_2d.flip_h = true
		sprite_2d.rotation = (PI / 2)

func handle_input(event: InputEvent):
	shoot()

var last_dir = 1
var can_shoot = true
#strzelanie
func shoot():
	var dir = Input.get_axis("ui_left","ui_right")
	if dir != 0:
		last_dir = dir
	if Input.is_action_just_pressed("strzal") and can_shoot:
		var add_bullet = bullet_scena.instantiate()
		var cooldown_shoot = add_bullet.cooldown
		add_bullet.global_position = character.global_position
		add_bullet.direction = last_dir
		add_bullet.shooter = "Player"
		add_bullet.damage *= character.stats.attack
		get_tree().current_scene.add_child(add_bullet)
		can_shoot = false
		await get_tree().create_timer(cooldown_shoot).timeout
		can_shoot = true
