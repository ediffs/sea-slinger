extends Area2D

@onready var death_timer = $deathTimer
@onready var ray_down = $rayDown
@onready var ray_left = $rayLeft
@onready var ray_up = $rayUp
@onready var ray_right = $rayRight

@export var Horizontal = true

@export var speed = 200
var dir_y = 1
var dir_x = 1

func _on_body_entered(body):
	body.get_node("PlayerCollision").queue_free()
	Engine.time_scale = 0.5
	$deathTimer.start()
	set_physics_process(false)

func _on_death_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	GameManager.load_level(GameManager.level)

func _physics_process(delta):
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
