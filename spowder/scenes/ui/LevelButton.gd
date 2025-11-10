
@tool extends Message

func _ready() -> void:
	visible = get_index() < LevelProgression.LEVEL_SCENES.size()
	message = str(get_index() + 1)

func _on_pressed() -> void:
	LevelProgression.inst.change_level(get_index())
