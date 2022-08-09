extends KinematicBody2D

var screen_size
var speed = 100
var moving: bool
var swooping: bool
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	moving = false
	swooping = false
	
func move():
	moving = true
	swooping = false
	pass

func swoop():
	moving = false
	swooping = true
	pass
	
func _physics_process(delta):
	if moving:
		check_position()
		move_and_slide(Vector2(speed, 0))
		
func check_position():
	if position.x >= screen_size.x - 50:
		speed = -100
	if position.x <= 50:
		speed = 100
	
