class_name State extends Node2D



enum state{idle, walking, charging_attack, attacking}
var facing_left= false
var current_state = state.idle
@onready var sprite:Sprite2D = $"../sprites/idle"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
