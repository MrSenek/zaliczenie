extends Area2D
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.start(2)



func _process(delta: float) -> void:
	if timer.is_stopped():
		var target = locate_healing_targets()
		print(target)
		timer.start()




func locate_healing_targets():
	var important_targets = []
	var targets =  get_overlapping_bodies()
	for body in targets:
		if body.is_in_group("enemy") and body.has_node("HP"):
			var cur_HP: float = body.get_node("HP").CURRENT_HEALTH
			var max_HP: float = body.get_node("HP").MAX_HEALTH
			var percent_HP:float  = cur_HP/max_HP
			if percent_HP < 0.5:
				important_targets.append({"node": body,"health": percent_HP})
	important_targets.sort_custom(func(a,b): return a["health"]<b["health"])
	if important_targets:
		return important_targets[0]
	else:
		return
