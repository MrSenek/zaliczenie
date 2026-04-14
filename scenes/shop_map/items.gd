extends Node2D

var org_items_list = ["+10HP", "Electric Weapon","Gravity Grenade", "Self Guiding Missile", "1,5x Damage"]

var items_list = org_items_list
func _ready() -> void:
	var item1 = items_list.pick_random()
	get_node("Item1/Node2D/Label").text = item1
	items_list.erase(item1)
	
	var item2 = items_list.pick_random()
	get_node("Item2/Node2D/Label").text = item2
	items_list.erase(item2)
	
	var item3 = items_list.pick_random()
	get_node("Item3/Node2D/Label").text = item3



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
