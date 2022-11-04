extends Node2D

onready var text_box = $TextBox
onready var text_entry = $TextEntry

var game_locations: Dictionary
var current_location: GameLocation
var directions = ["north","south","east","west"]

# Called when the node enters the scene tree for the first time.
func _ready():
	game_locations = {
		"woods": GameLocation.new("The woods", "You are in the woods. There are lots of trees."),
		"lake": GameLocation.new("The lake", "You are by the lake. It is very watery.")
	}
	
	game_locations["woods"].addLink("north","lake")
	game_locations["lake"].addLink("south","woods")

	current_location = game_locations["woods"]
	
	show_current_location()

class GameLocation:
	var directions = ["north","south","east","west"]
	var locations = {}
	
	var name: String
	var description: String
	var linked_locations: Dictionary
	
	func _init(name, description):
		self.name = name
		self.description = description
		self.linked_locations = {}
	
	func addLink(direction, destination):
		if directions.has(direction) == false:
			pass
		else:
			linked_locations[direction] = destination
			

func _on_TextEntry_text_entered(new_text):
	add_text("\n> " + new_text)
	text_entry.clear()
	if directions.has(new_text):
		if current_location.linked_locations.has(new_text) == false:
			add_text("You cannot go that way")
		else:
			var new_location = current_location.linked_locations[new_text]
			current_location = game_locations[new_location]
			show_current_location()
	else:
		add_text("Try one of : " + ", ".join(directions))

func add_text(text):
	text_box.text += text
	text_box.text += "\n"
	
func show_current_location():
	add_text(current_location.description)
	
	for x in current_location.linked_locations:
		add_text(x + " : " + game_locations[current_location.linked_locations[x]].name)
	
	text_entry.grab_click_focus()
	text_entry.grab_focus()


#if command in directions:
#        if command not in currentLocation.linkedLocations:
#            print('You cannot go that way')
#        else:
#            newLocationID = currentLocation.linkedLocations[command]
#            currentLocation = locations[newLocationID]
#    else:
#        print('Try one of: ' + ', '.join(directions)) # Show list of directions, separated by commas
