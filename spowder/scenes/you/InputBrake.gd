
extends InputNode

signal brake_started
signal brake_ended

@onready var character : CharacterBody3D = get_parent()

@export_range(0.0, 1.0, 0.01) var damping : float = 1.0

var is_braking : bool

func _input(event: InputEvent) -> void:
	if not enabled: return
	if event.is_action_pressed(&"brake"):
		is_braking = true
		brake_started.emit()
	elif event.is_action_released(&"brake"):
		is_braking = false
		brake_ended.emit()

func _physics_process(delta: float) -> void:
	if not is_braking: return

	character.velocity -= character.velocity * damping
