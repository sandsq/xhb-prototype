class_name Ability extends Resource

@export var ability_data: AbilityData
@export var ability_effect: AbilityEffect

func activate(source: CharacterBody2D, target: RichTextLabel):
	ability_effect.activate(ability_data, source, target)
