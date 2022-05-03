extends Node2D


func _ready():
	var items = ['stone', 'tree']
	var positions = []
	print(get_parent())
	for i in range(16):
		randomize()
		var a = int(rand_range(0, len(items)))
		var new_item = load("res://scenes/%s.tscn" % items[a]).instance()
		while true:
			var new_position = Vector2(rand_range(0, 1280), rand_range(0, 720))
			var correct_position = true
			if positions:
				for pos in positions:
					var vectorLength = pos.distance_to(new_position)
					if vectorLength <= 100:
						correct_position = false
						break
			if correct_position:
				new_item.position = new_position
				add_child(new_item)
				positions.append(new_position)
				break

		
		
		
