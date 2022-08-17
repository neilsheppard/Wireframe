extends ParallaxBackground

onready var front_layer = $FrontLayer
onready var middle_layer = $MiddleLayer
onready var back_layer = $BackLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	front_layer.motion_offset.x += -100 * delta
	middle_layer.motion_offset.x += -75 * delta
	back_layer.motion_offset.x += -50 * delta
