extends Control

var upscale: float = 1.5
var currently_active
var action_queue: Array[InputEvent]
var control_state: Globals.ControlState:
	set(value):
		match value:
			Globals.ControlState.PLAYER_CONTROL:
				self.grab_focus()
				background.color = Color("118855")
			Globals.ControlState.ABILITY_ASSIGNMENT:
				self.grab_focus()
				background.color = Color("9E8850")
			_:
				self.release_focus()
				background.color = Color("ffffff", 0)
		if currently_active != null and background != null:
			reset_currently_active_state()
		control_state = value
var ability_to_assign: Ability

@onready var left = $Left
@onready var right = $Right
@onready var back_left = $BackLeft
@onready var back_right = $BackRight
@onready var background = $Background

func _process(_delta: float) -> void:
	match control_state:
		Globals.ControlState.PLAYER_CONTROL:
			process_bar_input()
		Globals.ControlState.ABILITY_ASSIGNMENT:
			process_bar_input()
		_:
			pass


func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("activate_left") or event.is_action_pressed("activate_right"):
		action_queue.append(event)
		if action_queue.size() >= 2:
			action_queue = action_queue.slice(-2, action_queue.size())

## display the proper xhb halves based on which trigger is held
func process_bar_input():
	if Input.is_action_just_released("activate_left"):
		reset_currently_active_state()
	elif Input.is_action_just_released("activate_right"):
		reset_currently_active_state()

	if Input.is_action_pressed("activate_left") \
	and Input.is_action_pressed("activate_right"):
		if action_queue.size() < 2:
			# possible if triggers are held before entering xhb control mode
			return

		var last_action = action_queue.back()
		if last_action.is_action("activate_left"):
			reset_currently_active_state()
			currently_active = back_right
		elif last_action.is_action("activate_right"):
			reset_currently_active_state()
			currently_active = back_left
		else:
			print("action queue somehow contains something besides activate left/right")

	if Input.is_action_pressed("activate_left") \
	and !Input.is_action_pressed("activate_right"):
		currently_active = left
	elif Input.is_action_pressed("activate_right") \
	and !Input.is_action_pressed("activate_left"):
		currently_active = right

	if currently_active != null:
		currently_active.scale = Vector2(upscale, upscale)
		currently_active.set_state(true)
		background.scale = Vector2(upscale, upscale)


func reset_currently_active_state():
	if currently_active != null:
		currently_active.scale = Vector2(1.0, 1.0)
		currently_active.set_state(false)
		currently_active = null
	if background != null:
		background.scale = Vector2(1.0, 1.0)
