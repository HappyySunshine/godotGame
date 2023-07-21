class_name PlayerBody extends CharacterBody2D

@export var speed = 100
@export var ui_node : Node2D
var motion : Vector2
var collisionshape : CollisionShape2D
var attack_properties : PlayerAttack
var health: PlayerHealth
var player: State


# Called when the node enters the scene tree for the first time.
func _ready():
	health = $HealthComponent
	player = $PlayerControl
	attack_properties= $AttackComponent
	collisionshape = $AttackArea/CollisionShape2D
	

	
func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	motion = input_direction 
	if player.current_state!= player.state.attacking:
		if input_direction[0] < 0:
			player.facing_left = true
		elif input_direction[0] > 0:
			player.facing_left = false
	if Input.is_action_pressed("attack"):
		attack_properties.charge_attack()
	elif Input.is_action_just_released("attack"):
		if $Timer.time_left==0:
			return
		attack_properties.release_charge()

		
func update_state():
	if player.current_state== player.state.attacking or player.current_state== player.state.charging_attack :
		return	
	if velocity== Vector2.ZERO:
		player.current_state= player.state.idle
	else:
		player.current_state= player.state.walking
		
func _physics_process(delta):
	get_input()
	velocity= motion * speed 
	match player.current_state:
		player.state.charging_attack:
			velocity /= 2
		player.state.attacking:
			if attack_properties.first_attack:
				attack_properties.do_first_attack(self)
				attack_properties.first_attack= false
				return
	move_and_slide()

func _process(delta):
	update_state()
	pass
