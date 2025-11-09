class_name Level extends Node3D

static var inst : Level

signal completed

@export var next_level : String
@export var level_index : int = 0

var is_completed : bool

var required_pickup_count : int :
	get:
		var result := 0
		for pickup: Pickup in get_tree().get_nodes_in_group(&"pickup"):
			if pickup.required: result += 1
		return result

var required_enemy_count : int :
	get: return get_tree().get_node_count_in_group(&"enemy")


func _init() -> void:
	inst = self


func _ready() -> void:
	LevelProgression.unlock_up_to(level_index)
	is_completed = false

	for pickup: Node in get_tree().get_nodes_in_group(&"pickup"):
		pickup.tree_exited.connect(_check_completion)

	for enemy: Node in get_tree().get_nodes_in_group(&"enemy"):
		enemy.tree_exited.connect(_check_completion)



func _check_completion() -> void:
	if is_completed or not is_inside_tree(): return

	if required_pickup_count != 0: return
	if required_enemy_count != 0: return

	is_completed = true
	print("Level complete!")
	completed.emit()


func reset() -> void:
	get_tree().change_scene_to_file(scene_file_path)

func proceed() -> void:
	get_tree().change_scene_to_file(next_level)

func reset_or_proceed() -> void:
	if is_completed:
		proceed()
	else:
		reset()
