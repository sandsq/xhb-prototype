class_name Ability extends Node2D

@export var ability_data: AbilityData
@export var activation_effect: ActivationEffect

@onready var ability_graphic = $AbilityGraphic

func _ready() -> void:
	if ability_data == null:
		print("no ability data assigned to this ability")
	ability_graphic.color = ability_data.color
