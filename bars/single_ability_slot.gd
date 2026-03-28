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
@onready var click_indicator = $ClickIndicator
@onready var click_timer = $ClickIndicator/Timer

func _ready() -> void:
	label.text = hotkey_label
	ability = ability
	click_timer.timeout.connect(_on_click_timer_timeout)

func _process(_delta: float) -> void:
	if is_enabled and Input.is_action_just_pressed(hotkey.action):
		slot_hotkey_pressed.emit(ability, self)
		click_indicator.color.a = 0.5
		click_timer.start()

func _on_click_timer_timeout() -> void:
	click_indicator.color.a = 0
