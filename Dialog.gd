extends Node2D

@onready var label : Label = $Label
var message= "hello my name is bob"

var current_char = 0
var display = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_char_speed_timeout():
	if current_char == message.length():
		print(display)
		return
	display += message[current_char]
	current_char += 1
	label.text = display
	print("->",display)
	pass # Replace with function body.
