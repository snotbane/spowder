
@tool extends MeshInstance3D

const MIRROR_SHADER := preload("uid://b7twjt3twbrd")

var _resolution : int = 512
@export var resolution : int = 512 :
	get: return _resolution
	set(value):
		_resolution = value
		viewport.size = Vector2i.ONE * _resolution

var _source_camera : Camera3D

var viewport : SubViewport
var reflection_camera : Camera3D

func _init() -> void:
	set_layer_mask_value(1, false)
	set_layer_mask_value(2, true)

	viewport = SubViewport.new()
	viewport.disable_3d = false
	# viewport.transparent_bg = true
	viewport.render_target_update_mode = SubViewport.UPDATE_WHEN_VISIBLE
	resolution = resolution
	add_child.call_deferred(viewport, INTERNAL_MODE_BACK)

	reflection_camera = Camera3D.new()
	reflection_camera.set_cull_mask_value(2, false)
	reflection_camera.current = false
	viewport.add_child(reflection_camera)

	material_override = ShaderMaterial.new()
	material_override.shader = MIRROR_SHADER
	material_override.set_shader_parameter(&"reflection", viewport.get_texture())

func _ready() -> void:
	_source_camera = (EditorInterface.get_editor_viewport_3d() if Engine.is_editor_hint() else get_viewport()).get_camera_3d()
	reflection_camera.environment = get_world_3d().environment.duplicate()
	reflection_camera.environment.tonemap_mode = Environment.TONE_MAPPER_LINEAR


func _process(delta: float) -> void:
	var __source_camera : Camera3D = (EditorInterface.get_editor_viewport_3d() if Engine.is_editor_hint() else get_viewport()).get_camera_3d()

	if not __source_camera: return

	var __mirror_normal := -global_basis.z
	var __mirror_position := global_position
	var __reflected_position := __source_camera.global_position - __mirror_normal * 2.0 * __mirror_normal.dot(__source_camera.global_position - __mirror_position)
	reflection_camera.global_position = __reflected_position
	reflection_camera.fov = __source_camera.fov

	if is_equal_approx(__source_camera.global_basis.z.abs().dot(Vector3.UP), 1.0): return

	reflection_camera.global_basis = Basis.looking_at(-__source_camera.global_basis.z).scaled(Vector3(1,1,-1))
