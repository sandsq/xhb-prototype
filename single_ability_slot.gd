class_name SingleAbilitySlot extends Control

signal slot_hotkey_pressed(ability)

@export var hotkey: InputEvent
@export var hotkey_label: String
@export var AbilityScene: PackedScene

var ability
var is_enabled: bool = false

@onready var slot = $Slot
@onready var label = $Label


func _ready() -> void:
	if AbilityScene != null:
		ability = AbilityScene.instantiate()
		slot.add_child(ability)
	label.text = hotkey_label


func _process(delta: float) -> void:
	# probably don't actually do this here, just store the hotkey with the slot though
	if is_enabled and Input.is_action_just_pressed(hotkey.action):
		print("just pressed %s" % hotkey.action)
		if ability != null:
			slot_hotkey_pressed.emit(ability)
			#ability.activation_effect.activate(self, self)

#
#func activate(source, target) -> void:
	#if ability == null:
		#print("the ability is null, there is an issue")
		#return
	#ability.activate(source, target)
