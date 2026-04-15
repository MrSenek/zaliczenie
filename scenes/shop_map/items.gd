extends Node2D

var org_items_list = ["+10HP", "Electric Weapon","Gravity Grenade", "Self Guiding Missile", "1,5x Damage"]
var items_list = org_items_list.duplicate()
var player_in = {
	"item1": false,
	"item2": false,
	"item3": false
}
@onready var item_1: Area2D = $Item1
@onready var item_2: Area2D = $Item2
@onready var item_3: Area2D = $Item3

var item1
var item2
var item3

func _ready() -> void:
	item1 = items_list.pick_random()
	get_node("Item1/Node2D/Label").text = item1
	items_list.erase(item1)
	
	item2 = items_list.pick_random()
	get_node("Item2/Node2D/Label").text = item2
	items_list.erase(item2)
	
	item3 = items_list.pick_random()
	get_node("Item3/Node2D/Label").text = item3

func _process(delta: float) -> void:
	if player_in["item1"] == true and Input.is_action_just_pressed("strzal"):
		item_2.queue_free()
		item_3.queue_free()
		item_1.queue_free()
		give_item(item1)
	if player_in["item2"] == true and Input.is_action_just_pressed("strzal"):
		item_2.queue_free()
		item_3.queue_free()
		item_1.queue_free()
		give_item(item2)
	if player_in["item3"] == true and Input.is_action_just_pressed("strzal"):
		item_2.queue_free()
		item_3.queue_free()
		item_1.queue_free()
		give_item(item3)


func give_item(item):
	if item == "+10HP":
		PlayerData.max_health+=10
	if item == "Electric Weapon":
		PlayerData.owned_weapons.append("Electric Weapon")
	if item == "Gravity Grenade":
		PlayerData.owned_weapons.append("Gravity Grenade")
	if item == "Self Guiding Missile":
		PlayerData.owned_weapons.append("Self Guiding Missile")
	if item == "1,5x Damage":
		PlayerData.attack = 1.5




func _on_item_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in["item1"] = true
func _on_item_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in["item2"] = true
func _on_item_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in["item3"] = true
func _on_item_1_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in["item1"] = false
func _on_item_2_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in["item2"] = false
func _on_item_3_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in["item3"] = false
