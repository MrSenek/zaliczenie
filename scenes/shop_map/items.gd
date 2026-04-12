extends Node2D

var items_list = ["+10HP", "Electric Weapon","Gravity Grenade", "Self Guiding Missile", "1,5x Damage"]

func _ready() -> void:
	var item1 = items_list.pick_random()
	get_node("Item1/Label").text = item1
	
	var item2 = items_list.pick_random()
	while item1 == item2:
		item2 = items_list.pick_random()
	get_node("Item2/Label").text = item2
	
	var item3 = items_list.pick_random()
	while item1 == item3 and item2 == item3:
		item3 = items_list.pick_random()
	get_node("Item3/Label").text = item3
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
