extends Node2D

func update_legs(direction, on_floor, ducking):
	# flip
	if direction.x:
		$Legs.flip_h = direction.x < 0
	
	# state
	var state = "idle" if not ducking else "duck"
	if on_floor and direction.x and not ducking:
		state = "run"
	if not on_floor:
		state = "jump"
	$Legs.animation = state

func update_torso(direction, ducking, current_gun):
	pass
