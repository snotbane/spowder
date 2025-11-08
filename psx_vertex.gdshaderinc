
vec3 snap(vec3 vertex, mat4 matrix, float scale) {
	vec3 v = (matrix * vec4(vertex, 1.0)).xyz;
	v = floor(v / scale) * scale;
	return (inverse(matrix) * vec4(v, 1.0)).xyz;
}