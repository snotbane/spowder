
@tool extends TabContainer

func _init() -> void:
	child_order_changed.connect(_on_child_order_changed)

func _on_child_order_changed() -> void:
	current_tab = 0