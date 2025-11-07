
class_name Pawn extends CharacterBody3D

signal slide_collided(collision: KinematicCollision3D)

@export var bounce_factor := Vector2.ONE

# @export var bounce_lateral_by_velocity_vertical : Curve
# @export var bounce_vertical_by_velocity_lateral : Curve

var _velocity_pre_slide : Vector3

var gravity_vector : Vector3 :
	get: return ProjectSettings.get_setting("physics/3d/default_gravity_vector")
var gravity_force : Vector3 :
	get: return gravity_vector * ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	slide_collided.connect(_on_slide_collided)

func _physics_process(delta: float) -> void:
	if motion_mode == MOTION_MODE_GROUNDED:
		# if is_on_floor() and velocity.dot(gravity_vector) > 0.0:
		# 	velocity = Snotbane.flatten(velocity, gravity_vector)
		# else:
			velocity += gravity_force * delta

	_velocity_pre_slide = velocity
	move_and_slide()

	for i in get_slide_collision_count():
		slide_collided.emit(get_slide_collision(i))

func _on_slide_collided(collision: KinematicCollision3D) -> void:
	for i in collision.get_collision_count():
		bounce(collision.get_normal(i), _velocity_pre_slide)

func bounce(normal: Vector3, __velocity__: Vector3 = velocity) -> void:
	var __velocity_condensed := Snotbane.condensed(__velocity__)
	# var __bounce_vector := Vector2(
	# 	bounce_lateral_by_velocity_vertical.sample(__velocity_condensed.y),
	# 	bounce_vertical_by_velocity_lateral.sample(__velocity_condensed.x)
	# )
	velocity = __velocity__.bounce(normal) * Snotbane.expanded(bounce_factor)


func launch(global_impulse: Vector3) -> void:
	velocity += global_impulse
