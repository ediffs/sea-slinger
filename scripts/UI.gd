extends Control

@onready var label = %Label

var score = 0

func addScore(value):
	score += value
	update_score_label()

func update_score_label():
	label =  "Score: " + str(score)
