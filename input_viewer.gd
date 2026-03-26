extends Control

var default_color = Color("ffffff")
var active_color = Color("00ee99")

var trigger_press_order = []

@onready var l2 = $L2
@onready var l2_label = $L2/RichTextLabel
@onready var l1 = $L1
@onready var l_up = $LUp
@onready var l_right = $LRight
@onready var l_down = $LDown
@onready var l_left = $LLeft
@onready var r2 = $R2
@onready var r2_label = $R2/RichTextLabel
@onready var r1 = $R1
@onready var r_up = $RUp
@onready var r_right = $RRight
@onready var r_down = $RDown
@onready var r_left = $RLeft

func _ready() -> void:
	l2_label.text = ""
	r2_label.text = ""


func set_input_viewer_state(button: ColorRect, action_name: String):
	if Input.is_action_pressed(action_name):
		button.color = active_color
	else:
		button.color = default_color


func _process(_delta: float) -> void:

	if Input.is_action_just_pressed("iv_l2"):
		trigger_press_order.append("L2")
	if Input.is_action_just_pressed("iv_r2"):
		trigger_press_order.append("R2")

	trigger_press_order = trigger_press_order.slice(-2, trigger_press_order.size())

	if Input.is_action_pressed("iv_l2") and Input.is_action_pressed("iv_r2") and trigger_press_order.size() == 2:
		if trigger_press_order[0] == "L2":
			l2_label.text = "1"
			r2_label.text = "2"
		else:
			l2_label.text = "2"
			r2_label.text = "1"
	else:
		l2_label.text = ""
		r2_label.text = ""

	set_input_viewer_state(l2, "iv_l2")
	set_input_viewer_state(l1, "iv_l1")
	set_input_viewer_state(l_up, "iv_l_up")
	set_input_viewer_state(l_right, "iv_l_right")
	set_input_viewer_state(l_down, "iv_l_down")
	set_input_viewer_state(l_left, "iv_l_left")
	set_input_viewer_state(r2, "iv_r2")
	set_input_viewer_state(r1, "iv_r1")
	set_input_viewer_state(r_up, "iv_r_up")
	set_input_viewer_state(r_right, "iv_r_right")
	set_input_viewer_state(r_down, "iv_r_down")
	set_input_viewer_state(r_left, "iv_r_left")
