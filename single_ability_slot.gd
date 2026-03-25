class_name SingleAbilitySlot extends Control

@export var hotkey: InputEvent

var ability: Ability

@onready var slot = $Slot


func _ready() -> void:
	ability = slot.get_child(0)


func _process(delta: float) -> void:
	# probably don't actually do this here, just store the hotkey with the slot though
	if Input.is_action_just_pressed(hotkey.action):
		print("just pressed %s" % hotkey.action)
		ability.activation_effect.activate(self, self)

#
#func activate(source, target) -> void:
	#if ability == null:
		#print("the ability is null, there is an issue")
		#return
	#ability.activate(source, target)
