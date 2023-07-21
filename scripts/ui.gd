extends Node2D


func get_ui() -> Ui:
	return $CanvasLayer/UiHandler
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func display_hearts(number: int):
	print("hello from the ui",number)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


