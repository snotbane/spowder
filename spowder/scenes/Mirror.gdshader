shader_type spatial;
render_mode unshaded, cull_disabled;

#include "uid://b8tfxbpfli31i"

uniform sampler2D reflection;

uniform float scale = 0.04;

void vertex() {
	VERTEX = snap(VERTEX, MODELVIEW_MATRIX, scale);
}

void fragment() {
	ALBEDO = texture(reflection, SCREEN_UV).rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
