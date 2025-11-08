
class_name Pickup extends Area3D

signal collected

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group(&"player"):
		collect_by(body)


func collect_by(who: Node3D) -> void:
	_collect_by(who)
	collected.emit()
	queue_free()
	Music.inst.ensure_progress(mini(Music.inst.progress + 1, Music.COIL_PICKUP_TRANSITION - 1))
func _collect_by(who: Node3D) -> void: pass
