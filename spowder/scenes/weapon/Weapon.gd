
class_name Weapon extends Node3D

signal fired(global_impulse: Vector3)

@export var bullets_fired : int = 1

@export var bullet_uid : String
@onready var bullet_scene : PackedScene = load(bullet_uid)

@export var bullet_spawn_location : Node3D

@export_range(0.0, 180.0, 0.1) var bullet_deviation_degrees : float = 0.0
# @export_range(0.0, )

@export var recoil_impulse_power := Vector2.ONE
@export var bullet_impulse_power : float = 1.0

var owner_character : CharacterBody3D

var character_velocity : Vector3 :
	get: return owner_character.velocity if owner_character else Vector3.ZERO

func _ready() -> void:
	owner_character = Snotbane.find_parent_of_type(self, "CharacterBody3D")

func fire() -> void:
	for i in bullets_fired:
		create_bullet()

	fired.emit(global_basis.z * Snotbane.expanded(recoil_impulse_power))
	# Music.ensure_progress(Music.WEAPON_FIRED)


func create_bullet() -> Bullet:
	var result : Bullet = bullet_scene.instantiate()
	get_tree().root.add_child(result)
	result._populate(owner_character)
	_create_bullet(result)
	return result
func _create_bullet(bullet: Bullet) -> void:
	bullet.global_basis = Basis.looking_at(get_random_cone_direction(-bullet_spawn_location.global_basis.z, bullet_deviation_degrees), bullet_spawn_location.global_basis.y)
	bullet.global_position = bullet_spawn_location.global_position
	bullet.velocity = character_velocity - bullet.global_basis.z * bullet_impulse_power


func get_random_cone_direction(forward: Vector3, cone_half_angle: float) -> Vector3:
	# Random rotation around the forward axis
	var twist := Quaternion(forward, randf_range(0.0, TAU))

	# Random angle away from forward (uniformly distributed)
	var theta := acos(lerp(1.0, cos(deg_to_rad(cone_half_angle * 0.5)), randf()))
	var phi := randf() * TAU

	# Local direction offset
	var local_offset := Vector3(
		sin(theta) * cos(phi),
		sin(theta) * sin(phi),
		cos(theta)
	)

	# Align the offset to the forward direction using quaternion
	var align := get_stable_basis(forward)
	var rotated := align * local_offset

	# Apply twist (random spin around forward)
	return (twist * rotated).normalized()

func get_stable_basis(forward: Vector3) -> Basis:
	# Handle near-parallel cases robustly
	var up = Vector3.UP
	if abs(forward.dot(up)) > 0.999:  # Too close to vertical
		up = Vector3.RIGHT  # Use a different reference axis

	var right = up.cross(forward).normalized()
	var new_up = forward.cross(right).normalized()

	return Basis(right, new_up, forward)
