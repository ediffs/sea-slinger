extends StaticBody2D

@onready var ray_down = $rayDown
@onready var ray_left = $rayLeft
@onready var ray_up = $rayUp
@onready var ray_right = $rayRight

@export var Horizontal = true
@export var Moves = false

const speed = 200
var dir_y = 1
var dir_x = 1

func _physics_process(delta):
	if Moves == true:
		if Horizontal == true:
			if ray_left.is_colliding():
				dir_x = 1
			if ray_right.is_colliding():
				dir_x = -1
			position.x += dir_x * speed * delta
		elif Horizontal == false:
			if ray_up.is_colliding():
				dir_y = 1
			if ray_down.is_colliding():
				dir_y = -1
			position.y += dir_y * speed * delta

