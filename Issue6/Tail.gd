extends Node

var SEGMENT_SIZE = 50
var ANGLE = 2.5
var PHASE_STEP = 0.3
var WOBBLE_AMOUNT = 0.5
var SPEED = 4.0
var WIDTH = 800
var HEIGHT = 800

var tail_hook = preload("res://TailHook.tscn")
var tail_piece = preload("res://TailPiece.tscn")

var tail: Array

var time = 0

onready var segments = $"../Segments"

# Called when the node enters the scene tree for the first time.
func _ready():
	# set up alien
	for _x in range(10):
		tail.append(tail_piece.instance())
		
	tail.append(tail_hook.instance())
	
	# draw tail
	for index in tail.size():
		var piece = tail[index]
		segments.add_child(piece)
		piece.z_index = index % 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	
	var x = WIDTH - floor(SEGMENT_SIZE / 2)
	var y = HEIGHT - floor(SEGMENT_SIZE / 2)
	
	for index in segments.get_child_count():
		var piece = segments.get_child(index)
		piece.position = Vector2(x, y)
		
		var angle = ANGLE + WOBBLE_AMOUNT * sin(index * PHASE_STEP + time * SPEED)
		
		x += SEGMENT_SIZE * cos(angle)
		y -= SEGMENT_SIZE * sin(angle)
