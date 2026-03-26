extends Control

var upscale: float = 1.5
var currently_active
var action_queue: Array[InputEvent]

@onready var left = $Left
@onready var right = $Right
@onready var back_left = $BackLeft
@onready var back_right = $BackRight

func _process(_delta: float) -> void:
	if Input.is_action_just_released("activate_left"):
		reset_currently_active_state()
	elif Input.is_action_just_released("activate_right"):
		reset_currently_active_state()

	# if both triggers are held, need to check the most recent one
	if Input.is_action_pressed("activate_left") \
	and Input.is_action_pressed("activate_right"):
		if action_queue.size() < 2:
			print("action queue size is %s which sholudn't be possible" % action_queue.size())
		
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

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("activate_left") or event.is_action_pressed("activate_right"):
		#print("%s added" % event)
		action_queue.append(event)
		if action_queue.size() >= 2:
			action_queue = action_queue.slice(-2, action_queue.size())

	
func reset_currently_active_state():
	currently_active.scale = Vector2(1.0, 1.0)
	currently_active.set_state(false)
	currently_active = null
	
