
extends Node3D

@onready var launcher : Node3D = $launcher

@export var impulse_power := Vector2.ONE

signal fired(global_impulse: Vector3)

func fire() -> void:
	fired.emit(-launcher.global_basis.z * Snotbane.expanded(impulse_power))
