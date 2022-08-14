extends Node2D

onready var front_layer = $Front
onready var middle_layer = $Middle
onready var back_layer = $Back

var front_speed = 5
var middle_speed = 3
var back_speed = 1

var front_layer_size: float
var middle_layer_size: float
var back_layer_size: float

# Called when the node enters the scene tree for the first time.
func _ready():
	front_layer_size = (front_layer.texture.get_size().x / 2)
	middle_layer_size = (middle_layer.texture.get_size().x / 2)
	back_layer_size = (back_layer.texture.get_size().x / 2)

func _physics_process(delta):
	front_layer.position.x -= front_speed
	middle_layer.position.x -= middle_speed
	back_layer.position.x -= back_speed
	check_positions()
	
func check_positions():		
	if front_layer.position.x <= -front_layer_size:
		front_layer.position.x = 0
	
	if back_layer.position.x <= -back_layer_size:
		back_layer.position.x = 0
		
	if middle_layer.position.x <= -middle_layer_size:
		middle_layer.position.x = 0	
