extends Node2D

@onready var ability_color = $AbilityColor

func render(input_ability: Ability):
	ability_color.color = input_ability.ability_data.color
