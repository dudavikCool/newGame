extends Label

signal animationPassed

func _ready():
	for i in range(5):
		yield(get_tree().create_timer(0.05), "timeout")
		modulate.a += 0.2
	for i in range(20):
		yield(get_tree().create_timer(0.1), "timeout")
		modulate.a -= 0.05
	print(get_parent().get_parent())
	emit_signal("animationPassed")
	
