
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
func set_paused(value: bool) -> void:
	paused = value

@onready var menu : Control = get_parent()

@export var exit_scene : String

func _input(event: InputEvent) -> void:
	if not OS.is_debug_build(): return
	if event.is_action_pressed(&"toggle_menu"):
		PauseController.paused = not PauseController.paused

func _ready() -> void:
	inst = self
	process_mode = Node.PROCESS_MODE_ALWAYS
	menu.visible = PauseController.paused

func exit_to_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(exit_scene)
