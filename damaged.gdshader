shader_type canvas_item;

uniform vec4 color: source_color;
uniform float amount: hint_range(0.0, 1.0, 0.01);
void fragment() {
	vec4 textureColor= texture(TEXTURE, UV);
	
	COLOR= vec4(mix(textureColor.rgb, color.rgb,amount),textureColor.a);
	// Place fragment code here.
}
