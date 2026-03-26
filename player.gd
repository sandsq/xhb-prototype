extends CharacterBody2D

@export var speed: float = 100

var action_queue
var target

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
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()


func _on_hotkey_pressed(ability):
	print("in player, %s was pressed" % ability)
	ability.activate(self, effect_text)
	
	
