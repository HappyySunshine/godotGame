class_name PlayerAttack extends Attack

var charge_time = 1
var base_damage = 2
var dmg_multiplier= 2
var pelvic_power= 1500
var amount_charged= 0
var push_coefficient= 1.4
var first_attack = false
var second_attack = false
var vector = Vector2.ZERO
var collision_shape
var delay = 0.2
var can_attack= true
var player : State

func get_thrust():
	return vector * amount_charged * pelvic_power
	
func push_enemy(enemy: Node2D):
	var pushback = pow((amount_charged*10), push_coefficient) 
	var vector = Vector2(1,0)
	enemy.push(vector, pushback)
	
func hit_enemy(enemy : Health):
	var dmg = int(base_damage * dmg_multiplier * amount_charged) 
	enemy.take_damage(dmg)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	collision_shape = $"../AttackArea/CollisionShape2D"
	player = $"../PlayerControl"
	pass # Replace with function body.

func charge_attack():
	if can_attack== false or player.current_state == player.state.charging_attack:
		return
	player.current_state= player.state.charging_attack
	$"../Timer".start(charge_time)


func do_first_attack(body):
	body.velocity= get_thrust() 
	body.move_and_slide()
	var enemies = get_tree().get_nodes_in_group("enemies")
	var check_collision = load("res://scripts/check_collision_shapes.gd").CheckCollision.new()
	var new_shape= collision_shape
	var multiplier = 1
	if player.facing_left:
		multiplier = -1
	new_shape.position.x= 0	
	new_shape.position.x += $"../CollisionShape2D".shape.get_rect().size.x *multiplier
	check_collision.set_shape(new_shape	, 1)
	for enemy in enemies:
		check_collision.set_shape(enemy.get_node("Shape"), 2)
		if check_collision.is_overlapping():	
			hit_enemy(enemy.get_node("HealthComponent"))
			push_enemy(enemy)
	if amount_charged>0.4:
		pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func release_charge():
	if player.current_state != player.state.charging_attack:
		return
	amount_charged = 1 - $"../Timer".time_left
	$"../Timer".stop()
	vector = Vector2(-1,0) if player.facing_left else Vector2(1,0)
	first_attack= true
	player.current_state = player.state.attacking
	can_attack = false
	await  get_tree().create_timer(0.1).timeout
	player.current_state=player.state.idle	
	await  get_tree().create_timer(delay).timeout
	can_attack=true
	#await get_tree().create_timer(0.1).timeout
	#player.current_state=player.state.idle	
	
func _process(delta):
	pass


func _on_timer_timeout():
	release_charge()
	pass # Replace with function body.
