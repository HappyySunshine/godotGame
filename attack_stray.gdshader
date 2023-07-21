shader_type canvas_item;

uniform sampler2D color;
uniform sampler2D noise;
uniform float alpha_value;
uniform float disperse_value : hint_range(0.0, 1.0);
uniform float spread_value : hint_range(0.0, 10.0);
void fragment() {
	float size_x = float(textureSize(TEXTURE, 0).x);
	float size_y = float(textureSize(TEXTURE, 0).y);
	vec4 textureColor = texture(TEXTURE, UV);

	float visible = step(disperse_value,texture(noise, UV).x );
	textureColor.a= min(visible, textureColor.a);
	
	COLOR = textureColor;
}

void vertex(){
	float minValue = -50.0;
	float maxValue = 50.0;
	float randomValue = mix(minValue, maxValue, texture(noise, UV).x);
//	VERTEX.x += (randomValue * spread_value);
//	VERTEX.x *=-1.0;
//
//	VERTEX.x +=10.0;
	//	VERTEX.x += spread_value;	
}