class_name AbilityDataWater extends AbilityData

func activate(source: CharacterBody2D, target: RichTextLabel):
	print("%s casts water on %s" % [source, target])
	target.text = self.name
