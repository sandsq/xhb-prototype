extends Control

func get_all_slots():
	return self.get_children()
	
func set_state(is_enabled: bool):
	for child in self.get_children():
		child.is_enabled = is_enabled
