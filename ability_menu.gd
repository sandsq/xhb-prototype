extends Control

var SingleAbilitySlotScene = preload("res://bars/single_ability_slot.tscn")
var fire_ability: Ability = preload("res://abilities/fire_ability.tres")
var water_ability: Ability = preload("res://abilities/water_ability.tres")
var earth_ability: Ability = preload("res://abilities/earth_ability.tres")
var lightning_ability: Ability = preload("res://abilities/lightning_ability.tres")
var abilities: Array[Ability]

var cursor_offset: float = 2.0
var current_cursor_index: int = 0
var num_elements: int = 0

@onready var cursor = $Cursor
@onready var ability_container = $AbilityContainer

func _ready() -> void:
	abilities.append(fire_ability)
	abilities.append(water_ability)
	abilities.append(earth_ability)
	abilities.append(lightning_ability)
	
	for ability in abilities:
		var single_ability_slot = SingleAbilitySlotScene.instantiate()
		single_ability_slot.ability = ability
		single_ability_slot.hotkey_label = ""
		ability_container.add_child(single_ability_slot)
		
	num_elements = ability_container.get_children().size()
	
	current_cursor_index = calc_and_set_cursor_position_from_index(current_cursor_index, 0)

func _process(_delta: float) -> void:
	var offset = 0
	if Input.is_action_just_pressed("ui_right"):
		offset = 1
	if Input.is_action_just_pressed("ui_left"):
		offset = -1
	if Input.is_action_just_pressed("ui_down"):
		offset = ability_container.columns
	if Input.is_action_just_pressed("ui_up"):
		offset = -ability_container.columns
	current_cursor_index = calc_and_set_cursor_position_from_index(current_cursor_index, offset)

func calc_and_set_cursor_position_from_index(i: int, o: int):
	if i + o >= num_elements:
		return i
	if i + o < 0:
		return i
	cursor.position = ability_container.get_child(i + o).position + Vector2(cursor_offset, cursor_offset)
	return i + o
