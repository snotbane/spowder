
@tool class_name Message extends Control

var _bbcode : String
@export var bbcode : String :
	get: return _bbcode
	set(value):
		if _bbcode == value: return

		label.text = value + message
		_bbcode = value

@export var message : String :
	get: return label.text.substr(bbcode.length())
	set(value): label.text = bbcode + value

var _label_visible: bool = false
@export var label_visible : bool = false :
	get: return _label_visible
	set(value):
		_label_visible = value

		if label == null: return

		label.visible = _label_visible
func set_label_visible(value: bool) -> void:
	label_visible = value


var label : RichTextLabel

func _init(__message__ := String(), __bbcode__ := "[shake level=11 rate=40 connected=0]") -> void:
	label = RichTextLabel.new()
	label.bbcode_enabled = true
	label.fit_content = true
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.set_anchors_preset(Control.LayoutPreset.PRESET_FULL_RECT)
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child.call_deferred(label, false, INTERNAL_MODE_BACK)

	message = __message__
	bbcode = __bbcode__
	label_visible = label_visible




