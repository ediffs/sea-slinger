extends Node


var next_level_path
var level = 1
var score = 0

var level_container : Node2D
var ui : Control
var player : CharacterBody2D

func _ready():
	level_container = get_tree().get_first_node_in_group("level_container")
	ui = get_tree().get_first_node_in_group("ui")
	player = get_tree().get_first_node_in_group("player")
	
	load_level(level)

func set_level():
	level += 1
	score = 0
	ui.update_score_label(score)
	load_level(level)

func load_level(level):
	next_level_path = "res://levels/level_" + str(level) + ".tscn"
	
	var scene = load(next_level_path) as PackedScene
	
	if !scene:
		return
	# remove prev scene
	for child in level_container.get_children():
		child.queue_free()
		await child.tree_exited
	
	# set up new scene
	var instance = scene.instantiate()
	level_container.add_child(instance)
	
	# in case of death
	player.set_physics_process(true)
	player.get_node("PlayerCollision").set_deferred("disabled", false)
	
	player.velocity = Vector2.ZERO
	var player_start_position = get_tree().get_first_node_in_group("player_start_position") as Node2D
	player.position = player_start_position.position
	

func add_score():
	score += 1
	ui.update_score_label(score)

func _process(_delta):
	pass
