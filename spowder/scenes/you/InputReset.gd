extends Timer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"shoot"): start()
	elif event.is_action_released(&"shoot"): stop()

func _init() -> void:
	timeout.connect(reset_level)

func reset_level() -> void:
	if Level.inst == null: return

	Level.inst.completed.emit()


