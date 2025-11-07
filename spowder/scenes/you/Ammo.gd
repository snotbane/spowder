
class_name Ammo extends Control

@export var shell_uid : String
@onready var shell_scene : PackedScene = load(shell_uid)

var recent_reloads : Dictionary

var _shell_count : int = 1
@export var shell_count : int = 1 :
	get: return _shell_count
	set(value):
		_shell_count = value

		if shell_scene == null: return

		var available_prev := available_shells

		while value > get_child_count():
			add_child(shell_scene.instantiate())
		while value < get_child_count():
			get_child(-1).queue_free()

		available_shells = available_prev

@export var ignore_time : float = 0.1

var available_shells : int :
	get:
		var result := 0
		for child in get_children():
			if child.available: result += 1
		return result
	set(value):
		for i in get_child_count():
			get_child(i).available = i < value

func _ready() -> void:
	shell_count = shell_count
	available_shells = shell_count


func _on_character_collided(collision: KinematicCollision3D) -> void:
	for i in collision.get_collision_count():
		if Snotbane.NOW_MICRO - recent_reloads.get(collision.get_collider_rid(i), 0) < ignore_time: continue
		recent_reloads[collision.get_collider_rid(i)] = Snotbane.NOW_MICRO
		available_shells += 1
		break
