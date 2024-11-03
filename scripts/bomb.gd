extends Node2D

@onready var bomb_object = $detonationZone/bombObject
@onready var activation_zone = $activationZone
@onready var bomb_timer = $bombTimer
@onready var bob = $bob
@onready var sploded = $sploded

var exploding = false
var expTime = 0
var incr = 5
var expSize
var bombShot

func _ready():
	bob.visible = true
	sploded.visible = false
	bomb_object.disabled = true
	expSize = scale * incr
	bombShot = 6

func _physics_process(delta):
	if exploding == true:
		expTime += 4 * delta
		scale = lerp(scale, expSize, expTime)
		if scale == expSize:
			queue_free()

func _on_activation_zone_body_entered(_body):
	bomb_timer.start()
	activation_zone.queue_free()

func _on_bomb_timer_timeout():
	bob.visible = false
	sploded.visible = true
	exploding = true
	bomb_object.disabled = false

func _on_detonation_zone_body_entered(body):
	var rand_dir
	var first_value = bool(randi() % 2)
	if first_value:
		rand_dir = -1
	else:
		rand_dir = 1
	body.velocity *= Vector2(bombShot, bombShot) * Vector2(rand_dir, rand_dir)
	body.velocity = clamp(body.velocity * Vector2(bombShot, bombShot), Vector2(-3200, -3200), Vector2(3200, 3200))
	print(body.velocity)
