extends Node2D

class_name Attack

@export var damage= 3

func hit_enemy(enemy: Health):
	enemy.take_damage(damage)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
