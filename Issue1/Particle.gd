extends KinematicBody2D

var velocity = Vector2()
var timer = Timer.new()
var angle: float
var radius: float

# the initial speed of a particle
var SPEED = 300

# the time in seconds for which a particle is displayed
var MAX_AGE = 3

# how much a particle slows down each second
var DRAG = 0.8

func setup(_angle, _radius):
	self.angle = _angle
	self.radius = _radius
	
func explode():
	# convert the angle and distance from the explosion point in to x and y velocity for the particle
	velocity.x = SPEED * radius * sin(angle)
	velocity.y = SPEED * radius * cos(angle)
	
	# start the particle age timer
	timer.start()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(timer)
	timer.connect("timeout", self, "queue_free")
	timer.set_wait_time(MAX_AGE)

func _physics_process(delta):
	
	# update the particle's velocity - they slow down over time
	var drag = pow(DRAG, delta)
	velocity.x *= drag
	velocity.y *= drag
	
	# update the particle's velocity
	velocity = move_and_slide(velocity)
