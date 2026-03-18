extends Node
signal health_changed(amount)
signal death()

var MAX_HEALTH: int
var CURRENT_HEALTH: int
	

func set_health(amount):
	health_changed.emit(amount)

func damage_taken(amount):
	CURRENT_HEALTH -= amount
	health_changed.emit(CURRENT_HEALTH)
	if CURRENT_HEALTH <= 0:
		death.emit()

func get_hp(amount):
	CURRENT_HEALTH += amount
	if CURRENT_HEALTH > MAX_HEALTH:
		CURRENT_HEALTH = MAX_HEALTH
	
	health_changed.emit(CURRENT_HEALTH)

func _ready() -> void:
	MAX_HEALTH = get_parent().stats.max_health
	CURRENT_HEALTH = MAX_HEALTH
	set_health(MAX_HEALTH)
