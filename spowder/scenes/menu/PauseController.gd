
class_name PauseController extends Node

static var inst : PauseController

static var _mouse_mode_prev : Input.MouseMode

static var paused : bool :
	get: return inst.get_tree().paused
	set(value):
		if paused == value: return
		inst.get_tree().paused = value
		inst.menu.visible = value

		if paused:
			_mouse_mode_prev = Input.mouse_mode
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = _mouse_mode_prev

@onready var menu : Control = get_parent()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"toggle_menu"):
		PauseController.paused = not PauseController.paused

func _ready() -> void:
	inst = self
	process_mode = Node.PROCESS_MODE_ALWAYS
	menu.visible = PauseController.paused