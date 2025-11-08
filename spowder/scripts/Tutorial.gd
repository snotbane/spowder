
class_name Tutorial extends CanvasItem

enum State {
	DORMANT,
	PRIMED,
	VISIBLE,
	COMPLETED,
}

static func get_tutorial(tree: SceneTree, __name__: StringName) -> Tutorial:
	for node in tree.get_nodes_in_group(&"tutorial"):
		if node.name == __name__: return node
	return null

var _state := State.DORMANT
@export var state := State.DORMANT :
	get: return _state
	set(value):
		if value <= state: return
		_state = value

		visible = _state == State.VISIBLE

		if next:
			match _state:
				State.VISIBLE:		next.prime()
				State.COMPLETED:	next.appear()


@export var next : Tutorial


func _ready() -> void:
	add_to_group(&"tutorial")


func _process(delta: float) -> void:
	match state:
		State.PRIMED:
			if _check_appear():
				appear()
		State.VISIBLE:
			if _check_complete():
				complete()

func prime() -> void:
	state = State.PRIMED

func appear() -> void:
	if state != State.PRIMED: return
	state = State.VISIBLE
func _check_appear() -> bool: return false

func complete() -> void:
	state = State.COMPLETED
func _check_complete() -> bool: return false

func reset() -> void:
	_state = State.DORMANT
