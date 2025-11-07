
class_name Pawn extends CharacterBody3D

var gravity_vector : Vector3 :
	get: return ProjectSettings.get_setting("physics/3d/default_gravity_vector") * ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta: float) -> void:
	if motion_mode == MOTION_MODE_GROUNDED and not is_on_floor():
		velocity += gravity_vector

	move_and_slide()
