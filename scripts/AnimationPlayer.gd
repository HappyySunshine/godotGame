extends AnimationPlayer


var last_sprite2d : Sprite2D
var wait_current_animation_to_finish= false
var attackbar : TextureProgressBar
var player_sprites : Dictionary
var player : State   

 # Called when the node enters the scene tree for the first time.
func _ready():
	player_sprites= {"idle" : $"../sprites/idle", "attack": $"../sprites/attack", "walk": $"../sprites/walkie"  }
	attackbar=$"../sprites/AttackBar"
	player = $"../PlayerControl"
	self.play("idle")
	player_sprites.idle.visible=true
	last_sprite2d= player_sprites.idle
	#self.playback_process_mode= ANIMATION_PROCESS_IDLE
	pass # Replace with function body.


	
func play_new(name, canvasItem):
	last_sprite2d.visible= false
	self.play(name)
	canvasItem.visible= true
	last_sprite2d= canvasItem
	
	
func on_track_end():
	push_error("not implemented")
	pass	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func charging_attack():
	last_sprite2d.visible= false
	player_sprites.attack.visible= true
	player_sprites.attack.frame =0
	last_sprite2d= player_sprites.attack
	#while player.current_state== player.state.charging_attack:
	attackbar.visible= true
	attackbar.modulate.a= 1
	attackbar.set_value((1-$"../Timer".time_left )*100)
	
func release_attack():
	var tween:Tween = create_tween().set_parallel(true)
	var stray = $"../sprites/stray"
	stray.visible= true
	var time = 0.7
	var lambda= func(value):
		stray.get_material().set_shader_parameter("disperse_value", value)
	tween.tween_method(lambda,0.0, 1.0,time).set_trans(Tween.TRANS_LINEAR)
	var vec = Vector2(5,0)
	if player.facing_left:
		vec *= -1
	stray.flip_h = player.facing_left
	tween.tween_property(stray, "position", vec, time).from(Vector2.ZERO).set_trans(Tween.TRANS_LINEAR)
	$"../sprites/AnimationPlayer2".play("attackbar_fadeout")
	player_sprites.attack.frame =1
	
func _process(delta):
	last_sprite2d.flip_h= player.facing_left
	if wait_current_animation_to_finish== true:
		return
	if player.current_state == player.state.charging_attack:
		charging_attack()
		return
	if player.current_state == player.state.attacking:
		release_attack()
		return
	if player.current_state== player.state.walking:
		play_new("walkie",player_sprites.walk)
	if player.current_state== player.state.idle:
		play_new("idle", player_sprites.idle)



func _on_character_body_2d_attack():
	play_new("attack", player_sprites.attack)
	wait_current_animation_to_finish = true


func _on_animation_finished(anim_name):
	wait_current_animation_to_finish = false
	
