extends Node

@onready var bird = $"../Bird" as Bird
@onready var pipe_spawner = $"../PipeSpawner" as PipeSpawner
@onready var ground = $"../Ground" as Ground
@onready var fade = $"../Fade" as Fade
@onready var ui = $"../UI" as UI

var points = 0

func _ready():
	bird.game_started.connect(on_game_started)
	ground.bird_crashed.connect(on_end_game)
	pipe_spawner.bird_crashed.connect(on_end_game)
	pipe_spawner.bird_scored.connect(on_game_scored)
	
	
func on_game_started():
	pipe_spawner.start_spawing_pipes()

func on_end_game():
	if fade != null:
		fade.play()
		
	ground.stop()
	bird.kill()
	pipe_spawner.stop()
	ui.on_game_over()

func on_game_scored():
	points += 1
	ui.update_points(points)
	
	
