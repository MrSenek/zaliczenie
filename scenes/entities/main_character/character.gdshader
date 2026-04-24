shader_type canvas_item;

uniform float blur_amount : hint_range(0, 5) = 0.0;
uniform vec2 blur_direction = vec2(1.0, 0.0);

void fragment() {
	vec4 color = vec4(0.0);
	float count = 0.0;
	
	// Pobieramy kilka próbek tekstury wzdłuż kierunku ruchu
	for(float i = -blur_amount; i <= blur_amount; i++) {
		color += texture(TEXTURE, UV + (blur_direction * i * TEXTURE_PIXEL_SIZE));
		count += 1.0;
	}
	COLOR = color / count;
}