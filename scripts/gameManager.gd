extends Node

var starting_level = 1
var next_level_path

var level_container : Node2D
var ui : Control

func _ready():
	level_container = get_tree().get_first_node_in_group("level_container")
	
	load_level(starting_level)

func set_level():
	var level = get_tree().current_scene.scene_file_path # uh oh
	print(level)
	var next_level = level.to_int() + 1
	print(next_level)
	load_level(next_level)

func load_level(next_level):
	next_level_path = "res://levels/level_" + str(next_level) + ".tscn"
	
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
	
func add_score():
	ui.addScore(1)

func _process(_delta):
	pass
