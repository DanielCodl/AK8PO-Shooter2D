class_name Entity
extends CharacterBody2D

signal shoot(pos, dir, bullet_type)
var health := 100:
	set(value):
		health = value
		if health <= 0: 
			trigger_death()

func hit(damage, nodes):
	if not $Timers/InvulTimer.time_left:
		health -= damage
		$Timers/InvulTimer.start()
		flash(nodes)

func flash(nodes):
	var tween = create_tween()
	tween.tween_method(set_flash_value.bind(nodes), 0.0, 1.0, 0.1).set_trans(Tween.TRANS_QUAD)
	tween.tween_method(set_flash_value.bind(nodes), 1.0, 0.0, 0.4).set_trans(Tween.TRANS_QUAD)
	
func set_flash_value(value: float, nodes):
	for node in nodes:
		node.material.set_shader_parameter("Progress", value)
		
	
func trigger_death():
	print("death")

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#
#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
