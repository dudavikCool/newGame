extends StaticBody2D

signal countChanged(amount, itemName, mousePos)

var new_item

func _ready():
	randomize()
	new_item = Item.new('tree', int(rand_range(1, 4)))
	self.connect("countChanged", get_parent().get_parent(), 'countChanged')

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			emit_signal("countChanged", new_item.amount, new_item.itemName, get_global_mouse_position())
			for i in range(20):
				yield(get_tree().create_timer(0.05), "timeout")
				$Sprite.modulate.a -= 0.05
			get_parent().remove_child(self)
			queue_free()
