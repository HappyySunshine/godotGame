@tool 
extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	var rectangle = global_position - position - $"../..".position
	var size = shape.get_rect().size
	var end = shape.get_rect().end
	draw_circle(rectangle, 2, Color.BLUE)
	draw_circle(end, 2, Color.YELLOW)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()
	pass
