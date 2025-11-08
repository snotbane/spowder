shader_type spatial;
render_mode vertex_lighting, cull_disabled;

#include "uid://b8tfxbpfli31i"

uniform vec2 uv_scale = vec2(1);
uniform vec4 color: source_color = vec4(1);
uniform sampler2D albedo;
uniform sampler2D normal;
uniform sampler2D arm;

uniform float scale = 0.04;

void vertex() {
	VERTEX = snap(VERTEX, MODELVIEW_MATRIX, scale);
}

void fragment() {
	vec2 uv = UV * uv_scale;
	ALBEDO = (texture(albedo, uv) * color).rgb;
	NORMAL = texture(normal, uv).xyz;
	vec3 components = texture(arm, uv).xyz;
	AO = components.x;
	ROUGHNESS = components.y;
	METALLIC = components.z;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
