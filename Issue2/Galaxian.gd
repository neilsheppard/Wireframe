extends Node2D

var alien = preload("res://Alien.tscn")

var WIDTH = 400
var HEIGHT = 800


# Called when the node enters the scene tree for the first time.
func _ready():
	add_alien()

func add_alien():
	var i_alien = alien.instance()
	add_child(i_alien)
	i_alien.position = Vector2(100, 100)
	i_alien.move()
