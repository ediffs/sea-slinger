extends Area2D

func _on_body_entered(body):
	# re enabled in GameManager
	body.set_physics_process(false) 
	body.get_node("PlayerCollision").set_deferred("disabled", true)
	
	GameManager.set_level()

