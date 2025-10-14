extends CharacterBody2D

#Skeleton needs to be able to:
# - move
# - attack
# - take damage
# - die

#Code citing

#Title: 
#Author: 
#published: 
#permalink: 
#publisher: 
#commit hash: 

#Title: How to make NavigationAgent2D stop navigating? (4.2.2)
#Author: Cristian, smix8
#published: May 2024
#link: https://forum.godotengine.org/t/how-to-make-navigationagent2d-stop-navigating-4-2-2/58859
#publisher: Godot website - Godot Forum
 


#Title: navigation_introduction_2d.rst
#Author: Rageking8 et al. 
#published: Sept 16 2022
#permalink: https://github.com/godotengine/godot-docs/blob/6ebd2013679c35527b2053d984e44e112c77ec5a/tutorials/navigation/navigation_introduction_2d.rst
#publisher: Github
#commit hash: 4404daf6f3a0737b4410535cec2b4f51c3721454

#Github user R41Ryan as of Oct 27th 2024
#suggested that:
# I've found that, referring to NavigationAgent2D, 
# you can't set target_position and then call get_next_path_position()
# in the same _physics_process() call.
# If you do want to set the target_position and call get_next_path_position() 
# in the same frame (like say if the target_position is constantly changing), 
# set target_position in a _process() call, and call get_next_path_position() 
# in a _physics_process() call

#Note: global position coordinates are used

var count = 1

var player_reference = null

var movement_speed: float = 5.0
var movement_target_position: Vector2

var in_range: bool = false

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	navigation_agent.path_desired_distance = 10.0
	navigation_agent.target_desired_distance = 25.0
	
	#Dont await during _ready()
	actor_setup.call_deferred()
	
	
	
func actor_setup():
	#Wait for 1st physics frame so Navigation Server can sync
	await get_tree().physics_frame
	
	#attempt to get reference of player using absolute path
	
	player_reference = get_node_or_null("/root/Level/Player")
	
	if (player_reference):
		movement_target_position = player_reference.global_position
	
	
	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)
	

	
	# print(player_reference) debug check
	
func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target
	
func _physics_process(delta: float) -> void:
	
	
	if navigation_agent.is_navigation_finished():
		return
		
	var current_agent_position: Vector2 = global_position
	
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	
	move_and_slide()
	


func _process(delta: float) -> void:
	
	if (player_reference && !in_range):
		set_movement_target(player_reference.global_position)
	else:
		set_movement_target(global_position)


func setup_barrier(signal_type: Signal, entered: bool):
	if (entered): #was body entered signal?
		signal_type.connect(_on_barrier_entered)
	else:
		signal_type.connect(_on_barrier_exited)

func _on_barrier_entered(body: Node2D):
	in_range = true
	

func _on_barrier_exited(body: Node2D):
	in_range = false
