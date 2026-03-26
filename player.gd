extends CharacterBody2D

signal ability_assignment_finished

@export var speed: float = 100

var action_queue
var target
var control_state: Globals.ControlState:
	set(value):
		xhb.control_state = value
		control_state = value
var new_ability_to_assign: Ability

@onready var xhb = $XHB
@onready var effect_text: RichTextLabel = $EffectText

func _ready() -> void:
	for child in xhb.left.get_all_slots():
		child.slot_hotkey_pressed.connect(_on_hotkey_pressed)
	for child in xhb.right.get_all_slots():
		child.slot_hotkey_pressed.connect(_on_hotkey_pressed)
	for child in xhb.back_left.get_all_slots():
		child.slot_hotkey_pressed.connect(_on_hotkey_pressed)
	for child in xhb.back_right.get_all_slots():
		child.slot_hotkey_pressed.connect(_on_hotkey_pressed)

func _process(_delta: float) -> void:
	if control_state == Globals.ControlState.PLAYER_CONTROL:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = direction * speed
		move_and_slide()


func _on_hotkey_pressed(ability: Ability, slot: SingleAbilitySlot):
	match control_state:
		Globals.ControlState.PLAYER_CONTROL:
			print("in player, %s was pressed" % ability)
			if ability != null:
				ability.activate(self, effect_text)
		Globals.ControlState.ABILITY_ASSIGNMENT:
			print("ability assignment mode slot %s was pressed" % slot)
			slot.ability = new_ability_to_assign
			emit_signal("ability_assignment_finished")
			# slot.ability = ability
			# need to get the ability that was pressed on the menu. this ability is the one that is in the slot already
