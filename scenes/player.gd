extends CharacterBody2D
#@onready var player = $"."
@onready var player_anim = $AnimatedSprite2D

signal enemy_hit

var count: int = 0
var dx: int = 1
var dy: int = 1

func _physics_process(delta):
	
	# _physics_process() is called every "physics tick" before _process()
	
	velocity.x = 200 * dx
	velocity.y = 200 * dy

	var motion = velocity * delta
	move_and_collide(motion)

func _process(delta):
	
	# _process() is called after every physics tick
	
	# Animation sprites are stored in AnimatedSprite2D
	# Go to the 2D tab on the top of the window
	# Click AnimatedSprite2D under Player node
	# Each series of sprite frames is a different animation
	
	if (Input.is_key_pressed(KEY_C)):
		dx = 0
		dy = 0
		player_anim.play("attack")
	
	elif (Input.is_action_pressed("ui_up")):
		dx = 0
		dy = -1
		player_anim.play("run")
		
	elif (Input.is_action_pressed("ui_down")):
		dx = 0
		dy = 1
		player_anim.play("run")
	
	elif (Input.is_action_pressed("ui_right")):
		# running left & right use the same animated frames, but are mirrored
		player_anim.flip_h = false
		player_anim.play("run")
		dx = 1
		dy = 0
		
	elif (Input.is_action_pressed("ui_left")):
		player_anim.flip_h = true
		player_anim.play("run")
		dx = -1
		dy = 0
		
	else:
		player_anim.play("idle")
		dx = 0
		dy = 0
	
	return delta

func _hit_box(area: Area2D) -> void:
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
