
class_name Pickup extends Area3D

signal collected

@export var destroy_on_collect : bool = true
@export var required : bool = true

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group(&"player"):
		collect_by(body)


func collect_by(who: Node3D) -> void:
	_collect_by(who)
	collected.emit()

	if destroy_on_collect:
		queue_free()
	else:
		# Music.ensure_progress(mini(Music.inst.progress + 1, Music.COIL_PICKUP_TRANSITION - 1))
		pass
func _collect_by(who: Node3D) -> void: pass
