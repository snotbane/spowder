
extends Node

@onready var character : CharacterBody3D = get_parent()

@export_range(0.0, 1.0, 0.01) var damping : float = 1.0

var is_braking : bool

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"brake"):
		is_braking = true
	elif event.is_action_released(&"brake"):
		is_braking = false

func _physics_process(delta: float) -> void:
	if not is_braking: return

	character.velocity -= character.velocity * damping
