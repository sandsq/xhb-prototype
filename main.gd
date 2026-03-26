extends Node2D

var control_state = Globals.ControlState.ABILITY_MENU:
	set(value):
		ability_menu.control_state = value
		player.control_state = value
		control_state = value

@onready var player = $Player
@onready var ability_menu = $AbilityMenu

func _ready() -> void:
	player.ability_assignment_finished.connect(_on_ability_assignment_finished)
	control_state = Globals.ControlState.ABILITY_MENU
	ability_menu.ability_clicked.connect(_on_ability_clicked)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("focus_ability_menu"):
		control_state = Globals.ControlState.ABILITY_MENU
	if Input.is_action_just_pressed("focus_player"):
		control_state = Globals.ControlState.PLAYER_CONTROL

func _on_ability_clicked(ability: Ability):
	if ability != null:
		print("ability %s was clicked in the menu" % ability)
		control_state = Globals.ControlState.ABILITY_ASSIGNMENT
		player.new_ability_to_assign = ability

func _on_ability_assignment_finished():
	control_state = Globals.ControlState.ABILITY_MENU
