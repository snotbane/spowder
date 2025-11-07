
extends Node

signal triggered

@export var ammo : Ammo

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"shoot"):
		try_shoot()

func try_shoot() -> void:
	if ammo.available_shells > 0:
		ammo.available_shells -= 1
		triggered.emit()
	else:
		pass
