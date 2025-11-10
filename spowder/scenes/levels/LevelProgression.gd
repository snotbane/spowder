
class_name LevelProgression extends Node

const CONFIG_PATH := "user://levels.cfg"
static var LEVEL_SCENES : Array[PackedScene] = [
	load("res://spowder/scenes/levels/level_mostly_closed_box.tscn"),
	load("res://spowder/scenes/levels/level_open_cylinder.tscn"),
	load("res://spowder/scenes/levels/level_hall_with_no_floor.tscn"),
	load("res://spowder/scenes/levels/level_ufo_cylinder.tscn"),
]

static var inst : LevelProgression
static var data : ConfigFile

static var current_level : int = 1

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

func _init() -> void:
	inst = self

func change_level(idx: int = -1) -> void:
	current_level = idx
	Music.inst.clip_index = current_level
	levels_unlocked = maxi(levels_unlocked, current_level)
	if current_level < 0 or current_level >= LEVEL_SCENES.size():
		get_tree().change_scene_to_file("res://spowder/scenes/levels/main_menu.tscn")
	else:
		get_tree().change_scene_to_packed(LEVEL_SCENES[current_level])

func proceed_level() -> void:
	change_level(current_level + 1)
