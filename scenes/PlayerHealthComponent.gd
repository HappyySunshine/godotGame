class_name PlayerHealth extends Health

var ui: Ui

func _ready():
	super._ready()
	ui = $"..".ui_node.get_ui()
	call_deferred("set_hearts")
	invencible = true

func set_hearts():
	ui.set_health(current_health)
func take_damage(damage):
	if invencible:
		return
	super.take_damage(damage)
	print(current_health)
	ui.set_health(current_health)



func _on_timer_timeout():
	
	pass # Replace with function body.
