class_name FireAbilityEffect extends AbilityEffect

func activate(ability_data: AbilityData, source: CharacterBody2D, target: RichTextLabel):
	target.text = ability_data.name
