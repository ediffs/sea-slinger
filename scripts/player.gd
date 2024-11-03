extends CharacterBody2D

@onready var mouse_tracker = $mouseTracker
@onready var player_cam = $PlayerCam


var damping = 0.04
var swipe_started = false
var swipe_start = Vector2()
var minimum_drag = 5
var maximum_drag = 800
var speed = -5
var max_vel = 3200
var boost = 2
var time = 0

var swipe_vel_min = -50
var swipe_vel_max = 50
var moves = 0
const follow = 4.0
var base_collision = 200

var mouse_in = true
var in_range = false
var low_vel = false
var on_dot = false

var cam_time = 0
var zoom_lev = 0.8

func _ready():
	mouse_tracker.visible = false
	player_cam.zoom = Vector2(1 , 1)

func _input(event):
	if event.is_action_pressed("LMB") and mouse_in == true and low_vel == true:
		swipe_started = true
		swipe_start = get_global_mouse_position()
	if event.is_action_released("LMB") and swipe_started:
		swipe_started = false
		mouse_tracker.visible = false
		var swipe_end = get_global_mouse_position()
		var swipe = swipe_end - swipe_start
		if swipe.length() > minimum_drag:
			velocity = swipe * speed
			moves += 1
		if swipe.length() > maximum_drag:
			velocity = velocity.limit_length(max_vel)

func _process(delta):
	#camera
	if swipe_started == true and mouse_in == false:
		cam_time = 8 * delta
		player_cam.zoom = player_cam.zoom.lerp(Vector2(zoom_lev , zoom_lev), cam_time)
	else:
		player_cam.zoom = player_cam.zoom.lerp(Vector2(1 , 1), cam_time)

func _physics_process(delta):
	# movement
	velocity = lerp(velocity, Vector2.ZERO, damping)
	if swipe_started == true:
		rotate(get_angle_to(get_global_mouse_position()))
		
		# mouse tracker
		mouse_tracker.visible = true
		var mouse_pos = get_local_mouse_position()
		mouse_tracker.position = clamp(-mouse_pos, Vector2(-600 , -1), Vector2(0 , 1))
		
	# check for collisions
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		var reflect = collision.get_remainder().bounce(collision.get_normal())
		print(collision.get_normal())
		velocity = Vector2(velocity.bounce(collision.get_normal())) + base_collision * collision.get_normal()
		move_and_collide(reflect)
	if velocity <= Vector2(swipe_vel_max, swipe_vel_max) && velocity >= Vector2(swipe_vel_min, swipe_vel_min):
		low_vel = true
	else:
		low_vel = false


func _on_mouse_detection_mouse_entered():
	mouse_in = true

func _on_mouse_detection_mouse_exited():
	mouse_in = false

func _on_speedgate_body_entered(_body):
	velocity *= boost
