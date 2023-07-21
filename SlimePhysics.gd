extends CharacterBody2D


@export var speed = 20	

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass
	
func push(vector, pushback):
	move_and_collide(vector * pushback)
	

