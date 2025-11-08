shader_type spatial;
render_mode vertex_lighting, cull_disabled;

#include "uid://b8tfxbpfli31i"

uniform vec2 uv_scale = vec2(1);
uniform vec4 color: source_color = vec4(1);
uniform vec4 emissive: source_color = vec4(0,0,0,1);
uniform sampler2D albedo;
uniform sampler2D normal;
uniform sampler2D arm: hint_default_white;
uniform float ao_scale: hint_range(0.0, 1.0, 0.01) = 1.0;
uniform float rough_scale: hint_range(0.0, 1.0, 0.01) = 1.0;
uniform float metal_scale: hint_range(0.0, 1.0, 0.01) = 1.0;

uniform float scale = 0.1;

void vertex() {
	VERTEX = snap(VERTEX, MODELVIEW_MATRIX, scale);
}

void fragment() {
	vec2 uv = UV * uv_scale;
	ALBEDO = (texture(albedo, uv) * color).rgb;
	EMISSION = emissive.rgb * emissive.a;
	NORMAL = texture(normal, uv).xyz;
	vec3 components = texture(arm, uv).xyz;
	AO = components.x * ao_scale;
	ROUGHNESS = components.y * rough_scale;
	SPECULAR = 1.0;
	METALLIC = components.z * metal_scale;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
