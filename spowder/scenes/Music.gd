
class_name Music extends AudioStreamPlayer

enum {
	REST,
	WEAPON_FIRED,
	ANY_PICKUP_ACQUIRED,
	_UNKNOWN_1,
	_UNKNOWN_2,
	_UNKNOWN_3,
	COIL_PICKUP_TRANSITION,
	COIL_PICKUP_ACQUIRED,
}

static var inst : Music

static func ensure_progress(idx: int) -> void:
	if inst == null: return

	if inst.progress >= idx: return
	inst.clip_index = idx

@export var character : CharacterBody3D

var playback : AudioStreamPlaybackInteractive

var has_coil : bool :
	get: return progress > COIL_PICKUP_ACQUIRED

var progress : int = 0

var _clip : StringName
@export var clip : StringName :
	get: return _clip
	set(value):
		if _clip == value: return
		_clip = value
		_refresh_clip()
func _refresh_clip() -> void:
		if playback == null: return
		playback.switch_to_clip_by_name(_clip)

var _clip_index : int
@export var clip_index : int :
	get: return _clip_index
	set(value):
		if _clip_index == value: return
		_clip_index = value
		progress = maxi(progress, _clip_index)
		_refresh_clip_index()
func _refresh_clip_index() -> void:
		if playback == null: return
		if playback.get_current_clip_index() == _clip_index: return

		playback.switch_to_clip(_clip_index)

@export var rest_speed : float = 1.0

func _init() -> void:
	inst = self

func _ready() -> void:
	playback = get_stream_playback()
	_refresh_clip_index()

func _process(delta: float) -> void:
	if has_coil:
		clip_index = 0 if character.velocity.length() < rest_speed and character.is_on_floor() else progress
	else:
		pass
