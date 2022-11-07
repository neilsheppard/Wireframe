extends KinematicBody2D


export (int) var run_speed = 8
export (int) var jump_speed = -400
export (int) var gravity = 800
export (int) var inertia = 300
export (int) var max_speed = 160

var velocity = Vector2()
var jumping = false
var stopping = false
onready var sprite = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():	
	if Input.is_key_pressed(KEY_LEFT):
		if abs(velocity.x) <= max_speed:
			velocity.x -= run_speed
		if velocity.x < max_speed * -1:
			velocity.x = max_speed * -1
		stopping = false
	elif Input.is_key_pressed(KEY_RIGHT):
		if abs(velocity.x) <= max_speed:
			velocity.x += run_speed		
		if velocity.x > max_speed:
			velocity.x = max_speed 
		stopping = false
	else:
		stopping = true
		
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
		
	if stopping:
		if velocity.x > 0:
			velocity.x -= inertia * delta
			if velocity.x < 0:
				velocity.x = 0
		elif velocity.x < 0:
			velocity.x += inertia * delta
			if velocity.x > 0:
				velocity.x = 0
				
	move_and_slide(velocity, Vector2(0, -1))
	
	if jumping and is_on_floor():
		jumping = false
	if is_on_floor() and jumping == false:
		velocity.y = 0
