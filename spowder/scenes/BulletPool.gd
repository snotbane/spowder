
class_name BulletPool extends Node

static var inst : BulletPool

@export var prefill_count : int
@export var bullet_uid : String
@onready var bullet_scene : PackedScene = load(bullet_uid)

func _ready() -> void:
	inst = self

	for i in prefill_count:
		var bullet := create_bullet()
		bullet.hide()

func draw() -> Bullet:
	for i in get_child_count():
		if get_child(i).visible: continue
		return get_child(i)
	return create_bullet()

func create_bullet() -> Bullet:
	var result := bullet_scene.instantiate()
	add_child(result)
	return result
