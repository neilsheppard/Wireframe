extends KinematicBody2D

onready var sprite = $Sprite
onready var text = $Angle

enum Controller {SHIP_PAN, SHIP_DIVE}
var screen_size: Vector2
var delta_time: float
var start_position: Vector2
var velocity: Vector2
var flip_x: bool

var timer = Timer.new()
var speed = 100
var epsilon = 0.001
var ship_controller = Controller.SHIP_PAN

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	add_child(timer)
	timer.connect("timeout", self, "start_dive")
	timer.one_shot = true
	timer.set_wait_time(3)
	
func move():
	ship_controller = Controller.SHIP_PAN
	velocity = Vector2(100, 0)
	timer.start()
	
func _physics_process(delta):
	if ship_controller == Controller.SHIP_PAN:
		ship_controller_pan(delta)
	if ship_controller == Controller.SHIP_DIVE:
		ship_controller_dive(delta)
	
func ship_controller_dive(delta):
	delta_time += delta
	
	position = make_individual_dive(delta_time)
	var next_position = make_individual_dive(delta_time + epsilon)
	
	rotation_degrees = rad2deg(position.angle_to_point(next_position)) - 90
	
	if position.y > screen_size.y:
		ship_controller = Controller.SHIP_PAN
		position = start_position
		rotation_degrees = 0
		timer.start()

func ship_controller_pan(delta):
	rotation_degrees = 0
	position.x += velocity.x * delta
	if (position.x + (sprite.texture.get_size().x / 2)) >= screen_size.x - 50:
		velocity.x = -velocity.x
	if (position.x - (sprite.texture.get_size().x / 2)) <= 50:
		velocity.x = -velocity.x

func make_individual_dive(time):
	var dir = -1 if flip_x else 1
	
	var pos = dive_path(time)
	return Vector2(start_position.x + pos.x * dir, start_position.y + pos.y)
	
func dive_path(time):
	if time < 0.5:
		return Vector2(
			50 * (1 - cos(2 * time * PI)), 
			-50 * (sin(2 * time * PI))
		) 
		
	time -= 0.5
	return Vector2(
		100 * cos(time * 2),
		time * 350
	)

func start_dive():
	flip_x = position.x < (screen_size.x / 2)
	delta_time = 0
	start_position = position
	ship_controller = Controller.SHIP_DIVE
