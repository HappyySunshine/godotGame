extends Camera2D


@export var zone : Area2D
@export var player_body : PlayerBody
var old_player_pos : Vector2
var canvas_layer : CanvasLayer
var top_left
var viewport_length
var viewport_width
var margin_areas : Dictionary
var in_area: bool
var just_left_drag
# Called when the node enters the scene tree for the first time.
func _ready():
	canvas_layer = get_node("Ui/CanvasLayer")
	player_body = get_node("/root/root/PlayerBody")
	var halfed = get_viewport_rect().size * 0.5 
	var camera_pos =get_screen_center_position()
	top_left = get_camera_rect().position

func get_camera_rect() -> Rect2:
	var pos = get_screen_center_position() # Camera's center
	var half_size = get_viewport_rect().size *0.25 * 0.5
	var full_size : Vector2 = get_viewport_rect().size *0.25
	viewport_length= full_size.x
	viewport_width= full_size.y
	margin_areas = {$CanvasLayer/Top: Vector2(0,-viewport_width +16),$CanvasLayer/Right: Vector2(viewport_length -16,0), 
					$CanvasLayer/Bot: Vector2(0, viewport_width-16),$CanvasLayer/Left: Vector2(-viewport_length +16,0)}
	return Rect2(pos - half_size, pos + half_size)
	
func _draw():
	draw_circle(get_camera_rect().position, 10, Color.REBECCA_PURPLE)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func handle_drag():
	if $CanvasLayer/Drag.overlaps_body(player_body) == true:
		print("true", offset)
		if just_left_drag:
			var normalized=(player_body.position- get_screen_center_position()).normalized()
			position += normalized *1.3
		just_left_drag=false
#		self.offset += (player_body.position - old_player_pos)*1
		old_player_pos = player_body.position
	elif $CanvasLayer/Drag.overlaps_body(player_body) == false:
#		just_left_drag= true
		var normalized=(player_body.position- old_player_pos)
		position += normalized *1.8
		#print("false", offset)	
#		self.offset+= Vector2(-1,0)
		#$CanvasLayer.position = offset
		old_player_pos = player_body.position

	
	pass
func _process(delta):
	queue_redraw()

	
#	get_window().position.y -= delta *10
#	get_canvas_transform().y.y -= delta *10
#	offset.y-= delta *10
#	position.y-= delta *10
#	pass
	if zone.overlaps_body(player_body) == false:
		set_drag_vertical_enabled(true)
		set_drag_horizontal_enabled(true)
#		set_drag_margin(SIDE_TOP, 0.1)
		set_position(player_body.position) 
		
#		handle_drag()
		return
	old_player_pos = player_body.position	
	var entered_area= false
	if in_area:
		if is_in_any_area():
			return
		in_area=false

	for area in margin_areas:
		if area.has_overlapping_bodies():
			in_area=true
			entered_area=true
			position += margin_areas[area] *1
			#$CanvasLayer.position = position
			#position.y += margin_areas[area] *1	

func is_in_any_area():
	var in_any_area=false
	for area in margin_areas:
		if area.has_overlapping_bodies():
			return true
	return false
