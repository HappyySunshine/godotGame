class_name Ui extends Node2D

var sprites : AnimatedSprite2D
var texture : Texture2D
var camera 
var viewport 
var heart_width: int
var heart_height: int
var hearts : Array[Sprite2D]
var sprite_frames :SpriteFrames
var hearts_array: Array[int]
func _ready():
	sprites  = $"../AnimatedSprite2D"
	sprite_frames = sprites.get_sprite_frames()
	hearts_array.resize(3)
	var texture= sprite_frames.get_frame_texture("hearts", 0)
	viewport= get_tree().get_root().get_viewport()
	heart_width = texture.get_width() 
	heart_height = texture.get_height() 
	
	
	create_heart_sprites()
#	sprites.set_position(Vector2(0, 0))

func create_heart_sprites():
	var offset= Vector2(heart_width/2,heart_height/2)
	for i in range(3):
		var sprite= Sprite2D.new()	
		sprite.set_material(load("res://scenes/heart_material.tres"))
		sprite.set_position(offset)
		offset.x += heart_width + 1
		add_child(sprite)
		hearts.append(sprite)
		
		

func _draw():
	var offset= 0
	for sprite in hearts:
		#draw_texture(sprite.texture, Vector2(offset, 0))
		offset+= heart_width +1
	pass

func _process(delta):
	queue_redraw()
	pass

func set_health(health: int):
	var done= false
	for i in range(0, 3,1):
		var set_value=0
		health-= 1
		if health>=0:
			set_value+=1
		health-= 1
		if health>=0:
			set_value+=1
		hearts_array[i]= set_value
		hearts[i].texture= sprite_frames.get_frame_texture("hearts", hearts_array[i])
	queue_redraw()
		

func _on_timer_timeout():
	var lambda= func(value):
		sprites.get_material().set_shader_parameter("shine_progress", value)
	var tween = create_tween()
	
	tween.tween_method(lambda, 1.0, 0.0 , 0.8).set_trans(Tween.TRANS_LINEAR)
	pass # Replace with function body.
