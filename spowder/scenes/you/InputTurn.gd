
extends InputNode

@export var affector_yaw : Node3D
@export var affector_pitch : Node3D

@export var turn_speed_mouse := Vector2.ONE
@export var turn_speed_other := Vector2.ONE

var _turn_input_mouse : Vector2

func _input(event: InputEvent) -> void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED: return

	if event is InputEventMouseMotion:
		_turn_input_mouse = event.relative * get_window().content_scale_factor

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	if not enabled: return

	var __turn_input_other := Input.get_vector(Snotbane.INPUT_GHOST_CAMERA_LEFT, Snotbane.INPUT_GHOST_CAMERA_RIGHT, Snotbane.INPUT_GHOST_CAMERA_DOWN, Snotbane.INPUT_GHOST_CAMERA_UP)

	__turn_input_other = Vector2(__turn_input_other.y, -__turn_input_other.x) * turn_speed_other
	_turn_input_mouse = Vector2(_turn_input_mouse.y, _turn_input_mouse.x) * turn_speed_mouse * -1.0

	var __turn_vector := Snotbane.xy_(__turn_input_other + _turn_input_mouse)

	affector_pitch.rotate_x(__turn_vector.x * delta)
	affector_yaw.rotate_y(__turn_vector.y * delta)

	affector_pitch.rotation_degrees.x = clampf(affector_pitch.rotation_degrees.x, -90.0, +90.0)

	_turn_input_mouse = Vector2.ZERO
