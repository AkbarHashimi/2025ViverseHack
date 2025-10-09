extends CharacterBody2D
#@onready var player = $"."
@onready var player_anim = $AnimatedSprite2D

var default_speed: int = 100
var speed: int = 0

func _physics_process(delta):
	
	# _physics_process() is called every "physics tick" before _process()
	velocity = Vector2.ZERO
	
	if (Input.is_action_pressed("ui_right")):
		velocity += Vector2.RIGHT
	if (Input.is_action_pressed("ui_left")):
		velocity += Vector2.LEFT
	if (Input.is_action_pressed("ui_up")):
		velocity += Vector2.UP
	if (Input.is_action_pressed("ui_down")):
		velocity += Vector2.DOWN
		
	velocity = velocity.normalized() * speed
		
	move_and_collide(velocity * delta)

func _process(delta):
	
	if (Input.is_key_pressed(KEY_X)):
		speed = default_speed * 0.25
		player_anim.play("attack")
	elif (Input.is_key_pressed(KEY_Z)):
		speed = default_speed * 0.5
		player_anim.play("defend")
	else:
		speed = default_speed
		if (Input.is_action_pressed("ui_right")):
			player_anim.flip_h = false
			player_anim.play("run")
		elif (Input.is_action_pressed("ui_left")):
			player_anim.flip_h = true
			player_anim.play("run")
		elif (Input.is_action_pressed("ui_up")
				|| Input.is_action_pressed("ui_down")):
			player_anim.play("run")
		else:
			speed = 0
			player_anim.play("idle")
	
	return delta
