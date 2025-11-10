
class_name Music extends AudioStreamPlayer

const volume_curve : Curve = preload("uid://da6l6c4ks4ndp")
const pulse_curve : Curve = preload("uid://dp3g0iprdxeii")

static var inst : Music

static func ensure_progress(idx: int) -> void:
	if inst == null: return

	if inst.progress >= idx: return
	inst.clip_index = idx

var playback : AudioStreamPlaybackInteractive

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
		value = clampi(value, 0, 7)
		if _clip_index == value: return
		_clip_index = value
		progress = maxi(progress, _clip_index)
		_refresh_clip_index()
func _refresh_clip_index() -> void:
		if playback == null: return
		if playback.get_current_clip_index() == _clip_index: return

		playback.switch_to_clip(_clip_index)

func _init() -> void:
	inst = self
	stream = preload("res://spowder/audio/music/music.tres")
	autoplay = true

func _ready() -> void:
	playback = get_stream_playback()
	_refresh_clip_index()

func _process(delta: float) -> void:
	RenderingServer.global_shader_parameter_set(&"jitter_pulse", volume_curve.sample(clip_index - 1) * pulse_curve.sample(fmod(Snotbane.NOW_MICRO * 3.25, 1.0)))
