extends Node2D

class_name Health


@export var hp: int = 10 
@export var defense = 0
@export var sprite: Node2D
var sprite_material : ShaderMaterial
var current_health : int 
var invencible =false
func animate_damage():
	print("BLINKING")
	var sprite_material: ShaderMaterial = sprite.get_material()
	var tween: Tween = create_tween()
	var lambda = func(value):
		sprite_material.set_shader_parameter("amount", value)
	var blink_time = 0.3
	var blink_amount= 1
	var reverse= 1
	var intial_value=0
	var final_value=1
#	for i in blink_amount:
#		tween.tween_method(lambda,0.0,1.0,blink_time).set_trans(Tween.TRANS_LINEAR) 	
#		intial_value=reverse
#		reverse*= -1 
#		final_value= reverse
#
	tween.tween_method(lambda,0.0,1.0,blink_time-0.1).set_trans(Tween.TRANS_LINEAR)
	tween.tween_method(lambda,0.0,1.0,blink_time).set_trans(Tween.TRANS_LINEAR)
	tween.tween_method(lambda,1.0,0.0,blink_time).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	return tween

func take_damage(damage):
	print("taking damgae")
	damage-= defense
	if damage <= 0:
		return
	current_health-= damage
	var tween : Tween =animate_damage()
	if current_health <= 0:
		var lambda= func free_node(node):
			node.queue_free()
		tween.tween_callback(lambda.bind(get_node("..")))
		#get_node("..").queue_free()
#		get_node("..").queue_free()
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = hp
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hitbox_compoment_take_damage(amount):
	take_damage(amount)
	pass # Replace with function body.
