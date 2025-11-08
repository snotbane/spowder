shader_type spatial;
render_mode vertex_lighting;

uniform vec4 color: source_color = vec4(1);
uniform sampler2D albedo;

uniform float scale = 0.04;

void vertex() {
	vec3 v = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	v = floor(v / scale) * scale;
	VERTEX = (inverse(MODELVIEW_MATRIX) * vec4(v, 1.0)).xyz;
}

void fragment() {
	ALBEDO = (texture(albedo, UV) * color).rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
