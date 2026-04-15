extends Node

signal health_changed(amount)
signal death()


var MAX_HEALTH: int
var CURRENT_HEALTH: int

# Ta funkcja zostaje, wywołujemy ją zawsze przy zmianie HP
func set_health(amount):
	# Zabezpieczamy, żeby CURRENT_HEALTH nie przekroczyło MAX_HEALTH
	CURRENT_HEALTH = clamp(amount, 0, MAX_HEALTH)
	health_changed.emit(CURRENT_HEALTH)

func damage_taken(amount):
	set_health(CURRENT_HEALTH - amount) # Używamy set_health, by wysłać sygnał
	if CURRENT_HEALTH <= 0:
		death.emit()

func get_hp(amount):
	set_health(CURRENT_HEALTH + amount) # Używamy set_health, by wysłać sygnał

func _ready() -> void:
	PlayerData.stats_changed.connect(_on_player_stats_changed)
	MAX_HEALTH = PlayerData.max_health
	CURRENT_HEALTH = MAX_HEALTH
	set_health(CURRENT_HEALTH)

func _on_player_stats_changed():
	update_stats()

func update_stats():
	MAX_HEALTH = PlayerData.max_health
	# Usunąłem "CURRENT_HEALTH += 10", bo to psuło pasek przy każdej aktualizacji.
	# Teraz po prostu odświeżamy aktualny stan w granicach nowego MAX_HEALTH.
	set_health(CURRENT_HEALTH)
