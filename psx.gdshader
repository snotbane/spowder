shader_type spatial;
render_mode vertex_lighting, cull_disabled, shadows_disabled;

#include "uid://b8tfxbpfli31i"


uniform vec2 uv_scale = vec2(1);
uniform vec4 color: source_color = vec4(1);
uniform vec4 emissive: source_color = vec4(0,0,0,1);
uniform sampler2D albedo: filter_nearest;
uniform sampler2D normal: filter_nearest;
uniform sampler2D arm: hint_default_white, filter_nearest;
uniform float ao_scale: hint_range(0.0, 1.0, 0.01) = 1.0;
uniform float rough_scale: hint_range(0.0, 1.0, 0.01) = 1.0;
uniform float metal_scale: hint_range(0.0, 1.0, 0.01) = 1.0;

global uniform float jitter_scale;
global uniform float jitter_add;
global uniform float jitter_pulse;

void vertex() {
	//float dist = distance(CAMERA_POSITION_WORLD, (INV_PROJECTION_MATRIX * vec4(VERTEX, 1.0)).xyz);
	float dist = length((MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz);
	VERTEX = snap(VERTEX, MODELVIEW_MATRIX, jitter_scale + (jitter_pulse + jitter_add) * dist);
}

void fragment() {
	vec2 uv = UV * uv_scale;
	ALBEDO = (texture(albedo, uv) * color).rgb;
	EMISSION = ALBEDO * emissive.rgb * emissive.a;
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
