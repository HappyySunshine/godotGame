class CheckCollision:
	var shape1 = {}
	var shape2 = {}
	
	func set_shape(area2d, num):
		var target_shape
		if num ==1:
			target_shape= shape1
		else:
			target_shape= shape2
		target_shape.real_pos = area2d.global_position
		target_shape.l = area2d.global_position + area2d.shape.get_rect().position
		target_shape.r = area2d.global_position + area2d.shape.get_rect().end
		#target_shape.l.y*=-1
		#target_shape.r.y*=-1
	
		
	func is_overlapping():
		if shape2.l.x > shape1.r.x || shape2.r.x < shape1.l.x:
			return false
		if shape2.r.y < shape1.l.y || shape2.l.y > shape1.r.y:
			return false
		return true
	func printy():
		print(shape1, shape2)
