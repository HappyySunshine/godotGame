extends Node2D


@export var disable_controls =false
var path_follow : PathFollow2D
var track_player= false
var player : PlayerBody
var self_body : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	self_body = get_node("..")
	path_follow= $"../Path2D/PathFollow2D"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#    PathFollow2D
#	path_follow.progress+= delta *50
#	$"..".set_position(path_follow.get_position())
	pass

func _physics_process(delta):
	if disable_controls:
		return
	var direction = Vector2.ZERO
	var array= $Area2D.get_overlapping_bodies() 
	for body in array:
		if body is PlayerBody:
			player= body
			track_player= true
	if track_player:
		direction = (player.get_position() - self_body.position).normalized()
	self_body.velocity = direction * self_body.speed
	self_body.move_and_slide()
	pass # Replace with function body.
