extends Node2D

@onready var death_timer = $deathTimer


func _on_body_entered(body):
	body.velocity = Vector2.ZERO
	set_physics_process(false)
	
	# re enabled in GameManager
	body.set_physics_process(false) 
	body.get_node("PlayerCollision").set_deferred("disabled", true)
	
	Engine.time_scale = 0.5
	$deathTimer.start()



func _on_death_timer_timeout():
	Engine.time_scale = 1
	set_physics_process(true)
	GameManager.load_level(GameManager.level)

	
	#get_tree().reload_current_scene()
