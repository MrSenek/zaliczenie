extends ProgressBar
var start = 1


func _on_node_health_changed(amount: Variant) -> void:
	if start == 1:
		max_value = amount
		start = 0
	value = amount
	print("current HP: ",value,get_parent())
