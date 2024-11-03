extends Area2D

func _on_body_entered(_body):
	GameManager.set_level()
