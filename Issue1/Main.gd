extends Node2D

var explosion = preload("res://Particle.tscn")
var rng = RandomNumberGenerator.new()

# the size of the screen
var WIDTH = 800
var HEIGHT = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	start()

func start():
	# call the random explosion function every 1.5 seconds
	var timer = Timer.new()
	timer.set_wait_time(1.5)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "explode_random")
	add_child(timer)
	timer.start()
		
func explode_random():
	# select a random position on the screen
	var x = rng.randi_range(0, WIDTH)
	var y = rng.randi_range(0, HEIGHT)
	
	# call the explosion function for that position
	explode(x, y)
		
func explode(x, y):
	# generate 100 "particles"
	for i in 100:
		
		# for each particle, generate a random angle and distance
		var angle = rng.randf_range(0, 2 * PI)
		var radius = pow(rng.randf_range(0, 1), 0.5)
		
		# instantiate an instance of the explosion scene
		var i_explosion = explosion.instance()
		
		# setup the explosion
		i_explosion.setup(angle, radius)
		
		# add explosion to main scene
		add_child(i_explosion)
		
		# set explosion's poistion
		i_explosion.position = Vector2(x,y)
		
		# call explode function
		i_explosion.explode()
