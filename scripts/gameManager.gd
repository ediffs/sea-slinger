extends Node

const DEFAULT_SCORE = 100

var next_level_path
var level = 1
var score = DEFAULT_SCORE

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
	print(level)
	score = DEFAULT_SCORE
	load_level(level)

func load_level(level):
	# start the score counter
	score = DEFAULT_SCORE
	decrease_score(1000, get_process_delta_time())
	
	next_level_path = "res://levels/level_" + str(level) + ".tscn"
	print(next_level_path)
	
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
	
	#position the player at pstart
	player.velocity = Vector2.ZERO
	var player_start_position = get_tree().get_first_node_in_group("player_start_position") as Node2D
	player.position = player_start_position.position
	
	# in case of death
	player.set_physics_process(true)
	
	# wait a sec before reenabling collision so that sekiro: shadows don't die twice
	wait_collision(get_process_delta_time())


func add_score():
	score += 20
	ui.update_score_label(score)

func _process(delta):
	ui.update_score_label(score)
	if (score < 0):
		score = 0

func decrease_score(seconds, delta):
	for i in (DEFAULT_SCORE / 0.01):
		await get_tree().create_timer(delta * seconds).timeout
		score -= 0.01
		
func wait_collision(delta):
	await get_tree().create_timer(delta * 100).timeout
	player.get_node("PlayerCollision").set_deferred("disabled", false)
