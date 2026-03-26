class_name SingleAbilitySlot extends Control

signal slot_hotkey_pressed(ability: Ability, slot: SingleAbilitySlot)

@export var hotkey: InputEvent
@export var hotkey_label: String
@export var ability: Ability:
	set(value):
		if value != null and ability_renderer != null:
			print("displaying new ability %s" % value)
			ability_renderer.render(value)
		ability = value

var is_enabled: bool = false

@onready var label = $Label
@onready var ability_renderer = $AbilityRenderer

func _ready() -> void:
	label.text = hotkey_label
	ability = ability


func _process(_delta: float) -> void:
	# probably don't actually do this here, just store the hotkey with the slot though
	if is_enabled and Input.is_action_just_pressed(hotkey.action):
		print("just pressed %s" % hotkey.action)
		slot_hotkey_pressed.emit(ability, self)
			#ability.activation_effect.activate(self, self)

#
#func activate(source, target) -> void:
	#if ability == null:
		#print("the ability is null, there is an issue")
		#return
	#ability.activate(source, target)
