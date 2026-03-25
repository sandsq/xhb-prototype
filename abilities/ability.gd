class_name Ability extends Node2D

@export var ability_data: AbilityData

@onready var ability_graphic = $AbilityGraphic

func _ready() -> void:
	if ability_data == null:
		print("no ability data assigned to this ability")
	ability_graphic.color = ability_data.color

func activate(source: CharacterBody2D, target: RichTextLabel):
	ability_data.activate(source, target)
