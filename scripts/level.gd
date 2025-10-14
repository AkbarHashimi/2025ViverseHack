extends Node2D

func _ready():
	var enemy = get_node("Skeleton")
	var playerBarrier = get_node("Player").get_node("Barrier")
	
	var signal_entered = playerBarrier.body_entered
	var signal_exited = playerBarrier.body_exited
	
	if (enemy.has_method("setup_barrier")):
		enemy.setup_barrier(signal_entered, true)
		enemy.setup_barrier(signal_exited, false)
	
	
	
	
	
	
