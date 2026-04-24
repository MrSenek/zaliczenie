extends Sprite2D

func _ready():
	# Animujemy znikanie i usuwamy "ducha"
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.4) # Znika w 0.4s
	tween.finished.connect(queue_free)
