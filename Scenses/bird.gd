extends CharacterBody2D

class_name Bird

signal game_started

@export var gravity = 900.0
@export var jump_force = -300
@export var rotation_speed = 2
@onready var animation_player = $AnimationPlayer

const max_speed = 400

var is_started = false
var is_should_process_input = true

func _ready():
	velocity = Vector2.ZERO
	animation_player.play("idle")
	
func _physics_process(delta):
	if is_should_process_input and Input.is_action_just_pressed("jump"):
		if not is_started:
			game_started.emit()
			animation_player.play("flap_wings")
			is_started = true
		
		jump()
		
	if is_started:
		velocity.y += gravity * delta
		if velocity.y > max_speed:
			velocity.y = max_speed
			
		move_and_collide(velocity * delta)
		
		rotate_bird()
	
func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-30)
	
func rotate_bird():
	var rotation_deg = rad_to_deg(rotation)
	
	if velocity.y > 0 and rotation_deg < 90:
		rotation += rotation_speed * deg_to_rad(1)
	elif velocity.y < 0 and rotation_deg > -30:
		rotation -= rotation_speed * deg_to_rad(1)
	
func kill():
	is_should_process_input = false

func stop():
	animation_player.stop()
	gravity = 0
	velocity = Vector2.ZERO
