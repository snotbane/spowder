
@tool extends Message

@export var level_scene : String

func _on_pressed() -> void:
	get_tree().change_scene_to_file(level_scene)
