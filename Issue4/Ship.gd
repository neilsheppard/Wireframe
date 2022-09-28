extends Sprite

var xSpeed = 0
var ySpeed = 0
var angle = 0
var new_angle = 0
var acceleration = 0.02
var rotation_speed = 1
var thrust_gfx = load("res://spaceship_thrust.png")
var ship_gfx = load("res://spaceship.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	texture = ship_gfx

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	new_angle = rotation_degrees
	
	# Update angle based on LEFT / RIGHT key press
	if (Input.is_key_pressed(KEY_RIGHT)):
		new_angle += rotation_speed

	if (Input.is_key_pressed(KEY_LEFT)):
		new_angle -= rotation_speed
	
	# on UP key press update sprite
	# update x and y velocity
	if (Input.is_key_pressed(KEY_UP)):
		texture = thrust_gfx
		xSpeed += cos(deg2rad(new_angle + 270)) * acceleration
		ySpeed += sin(deg2rad(new_angle + 270)) * acceleration
	else:
		texture = ship_gfx
	
	# Reset position, angle and speed of ship
	if (Input.is_key_pressed(KEY_SPACE)):
		xSpeed = 0
		ySpeed = 0
		new_angle = 0
		position = Vector2(400,400)
		
	# Update sprites rotation and position
	rotation_degrees = new_angle
	position = position + Vector2(xSpeed, ySpeed)
