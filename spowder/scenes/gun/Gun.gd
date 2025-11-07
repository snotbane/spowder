
extends Node3D

@export var impulse_power := Vector2.ONE

signal fired(global_impulse: Vector3)

func fire() -> void:
	fired.emit(-global_basis.z * Snotbane.expanded(impulse_power))
