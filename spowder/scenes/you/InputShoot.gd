
extends InputNode

@export var ammo : Ammo

var weapon : Weapon :
	get: return get_child(0) if get_child(0) is Weapon else null

func _input(event: InputEvent) -> void:
	if not enabled: return
	if event.is_action_pressed(&"shoot"):
		try_shoot()

func try_shoot() -> void:
	if ammo.available_shells > 0:
		ammo.available_shells -= 1
		weapon.fire(ammo.available_shells == 0)
	else:
		weapon.misfire()
