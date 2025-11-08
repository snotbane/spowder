
extends Node

@export var ammo : Ammo

var weapon : Weapon :
	get: return get_child(0) if get_child(0) is Weapon else null

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"shoot"):
		try_shoot()

func try_shoot() -> void:
	if ammo.available_shells > 0:
		ammo.available_shells -= 1
		weapon.fire()
	else:
		pass
