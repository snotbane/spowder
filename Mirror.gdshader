shader_type spatial;
render_mode unshaded, cull_disabled;

uniform sampler2D reflection;

void fragment() {
	ALBEDO = texture(reflection, SCREEN_UV).rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
