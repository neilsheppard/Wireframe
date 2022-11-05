class_name GameLocation
var name: String
var description: String
var linked_locations: Dictionary

func _init(name, description):
	self.name = name
	self.description = description
	self.linked_locations = {}
