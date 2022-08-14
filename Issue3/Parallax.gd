extends Node2D

onready var front_layer = $Front
onready var middle_layer = $Middle
onready var back_layer = $Back

var back_speed = 1
var middle_speed = 3
var front_speed = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	front_layer.position.x -= front_speed
