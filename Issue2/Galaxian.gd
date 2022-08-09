extends Node2D

var alien = preload("res://Alien.tscn")

var WIDTH = 400
var HEIGHT = 800

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_alien()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func add_alien():
	var i_alien = alien.instance()
	add_child(i_alien)
	i_alien.position = Vector2(200, 100)
	i_alien.move()

func move_alien():
	pass
	
