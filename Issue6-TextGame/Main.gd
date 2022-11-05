extends Node2D

onready var text_box = $TextBox
onready var text_entry = $TextEntry

var LOCATION_MANAGER = GameLocationManager.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	LOCATION_MANAGER.add_location("woods", "The woods", "You are in the woods. There are lots of trees.")
	LOCATION_MANAGER.add_location("lake", "The lake", "You are by the lake. It is very watery.")
	
	LOCATION_MANAGER.add_location_link("woods", "north","lake")
	LOCATION_MANAGER.add_location_link("lake", "south", "woods")

	LOCATION_MANAGER.current_location = LOCATION_MANAGER.locations["woods"]
	
	show_current_location()

func _on_TextEntry_text_entered(new_text):
	add_text("\n> " + new_text)
	text_entry.clear()
	if LOCATION_MANAGER.directions.has(new_text):
		if LOCATION_MANAGER.current_location.linked_locations.has(new_text) == false:
			add_text("You cannot go that way")
		else:
			var new_location = LOCATION_MANAGER.current_location.linked_locations[new_text]
			LOCATION_MANAGER.current_location = LOCATION_MANAGER.locations[new_location]
			show_current_location()
	else:
		add_text("Try one of : " + ", ".join(LOCATION_MANAGER.directions))

func add_text(text):
	text_box.text += text
	text_box.text += "\n"
	
func show_current_location():
	add_text(LOCATION_MANAGER.current_location.description)
	
	for x in LOCATION_MANAGER.current_location.linked_locations:
		add_text(x + " : " + LOCATION_MANAGER.locations[LOCATION_MANAGER.current_location.linked_locations[x]].name)
	
	text_entry.grab_click_focus()
	text_entry.grab_focus()
