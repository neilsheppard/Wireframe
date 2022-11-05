class_name GameLocationManager
var directions = ["north","south","east","west"]
var locations = {}

var current_location: GameLocation

func add_location_link(location, direction, destination):
	if directions.has(direction) == false:
		pass
	else:
		locations[location].linked_locations[direction] = destination
		
func add_location(identifier, name, description):
	locations[identifier] = GameLocation.new(name, description)
