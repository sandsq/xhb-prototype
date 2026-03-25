class_name AbilityDataFire extends AbilityData

func activate(source: CharacterBody2D, target: RichTextLabel):
	print("%s casts fire on %s" % [source, target])
	target.text = self.name
