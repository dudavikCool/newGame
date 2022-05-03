extends Node2D

func _ready():
	pass
	
func countChanged(amount, itemName, mousePos):
	yield(pop_upLabel(amount, mousePos), 'completed')

	var label = $Control.get_node("Panel/%s" % itemName)
	var num = int(label.text)
	label.text = str(num + amount)
	
func pop_upLabel(amount, mousePos):
	var popUpLabel = load('res://guiScenes/pop-upLabel.tscn').instance()
	popUpLabel.text = '+' + str(amount)
	$Control.add_child(popUpLabel)
	popUpLabel.rect_global_position = mousePos
	add_child(popUpLabel)
	yield(popUpLabel, "animationPassed")
	
	
