extends Node

var max_time = 1
var value = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value += delta
	if value >= max_time:
		value = max_time
	pass
