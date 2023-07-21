shader_type canvas_item;


uniform vec4 shine_color : source_color = vec4(1.0);
uniform float shine_progress : hint_range(-3.0, 1.0, 0.01) = 0.0;
uniform float shine_size : hint_range(0.01, 1.0, 0.01) = 0.1;
uniform float shine_angle : hint_range(0.0, 180.9, 0.1) = 45.0;

float scale(float value, float inMin, float inMax, float outMin, float outMax) {
    return (value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
}

void fragment() {
    COLOR = texture(TEXTURE, UV);
	float slope = tan(radians(shine_angle));
	//float progress = scale(shine_progress, 
//	0.0, 1.0,-1.0 - shine_size - shine_size * slope, 1.0);
	float progress = shine_progress;
//	progress=  0.05;
	//float shine = 0.9;
//	 step(UV.x- UV.y, progress+shine_size) -
	float slope2 = radians(shine_angle);
	 float shine =  step(UV.x*slope- UV.y, progress+shine_size + shine_size * slope) -
	 	 step( (UV.x*slope- UV.y), progress);
    COLOR.rgba = mix(COLOR.rgba, shine_color.rgba, shine*1.0);
}