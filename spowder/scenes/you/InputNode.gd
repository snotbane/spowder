
class_name InputNode extends Node

var _enabled : bool = true
@export var enabled : bool = true :
	get: return _enabled
	set(value):
		if _enabled == value: return
		_enabled = value
		_refresh_enabled()
func _refresh_enabled() -> void: pass
