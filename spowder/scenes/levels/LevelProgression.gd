
@tool class_name LevelProgression extends GridContainer

const CONFIG_PATH := "user://levels.cfg"

static var data : ConfigFile

static var levels_unlocked : int :
	get:
		data.load(CONFIG_PATH)
		return data.get_value("default", "levels_unlocked", 1)
	set(value):
		data.set_value("default", "levels_unlocked", value)
		data.save(CONFIG_PATH)

static func _static_init() -> void:
	data = ConfigFile.new()
	var error := data.load(CONFIG_PATH)

	if error:
		data.save(CONFIG_PATH)

static func unlock_up_to(idx: int) -> void:
	levels_unlocked = maxi(levels_unlocked, idx)

@export_tool_button("Reveal Config") var reveal_config := func() -> void:
	OS.shell_open(ProjectSettings.globalize_path(CONFIG_PATH))
@export_tool_button("Reset Config") var reset_config := func() -> void:
	DirAccess.remove_absolute(ProjectSettings.globalize_path(CONFIG_PATH))

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = false
	refresh_buttons()


func refresh_buttons() -> void:
	var _levels_unlocked := levels_unlocked
	for i in get_child_count():
		get_child(i).disabled = i >= _levels_unlocked



