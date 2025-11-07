
extends Control

var _available : bool = true
@export var available : bool = true :
	get: return _available
	set(value):
		if _available == value: return
		_available = value
		modulate = Color(1, 1, 1, 1.0 if _available else 0.25)

func consume() -> void:
	available = false
