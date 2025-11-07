
extends Node

signal triggered

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"shoot"):
		triggered.emit()
