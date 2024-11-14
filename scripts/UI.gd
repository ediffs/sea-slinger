extends Control

@onready var label = %Label
@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

var score = 0

func update_score_label(score):
	label.text =  "Score: " + str(ceil(score))
