extends Area2D

var dotTime = 0
var on_dot = false
var player

func _physics_process(delta):
	if on_dot == true:
		dotTime += 0.4 * delta
		player.velocity = Vector2(0, 0)
		player.position = player.position.lerp(position, dotTime)
	if dotTime > 0.2:
		on_dot = false
	if on_dot == false:
		dotTime = 0

func _on_body_entered(body):
	on_dot = true
	player = body


