extends Area2D

@onready var death_timer = $deathTimer


func _on_body_entered(body):
	body.velocity = Vector2.ZERO
	body.set_physics_process(false)
	body.get_node("PlayerCollision").queue_free()
	Engine.time_scale = 0.5
	$deathTimer.start()
	set_physics_process(false)


func _on_death_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
