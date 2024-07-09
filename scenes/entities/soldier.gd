extends Entity

var x_direction := 1
var speed = Global.enemy_parameters["soldier"]["speed"]
var speed_modifier := 1
var attack := false
@onready var player = get_tree().get_first_node_in_group("Player")

func _ready():
	health = Global.enemy_parameters["soldier"]["health"]

func _process(_delta):
	velocity.x = x_direction * speed * speed_modifier
	check_cliff()
	check_player_distance()
	animate()
	move_and_slide()
	
func check_player_distance():
	if position.distance_to(player.position) < 120:
		attack = true
		speed_modifier = 0
	else:
		attack = false
		speed_modifier = 1
	
func animate():
	$Sprite2D.flip_h = x_direction < 0
	if attack:
		var side = "right"
		var difference = (player.position - position).normalized()
		$Sprite2D.flip_h = difference.x < 0
		if difference.y < 0.5 and abs(difference.x) < 0.4:
			side = "up"
		if difference.y > 0.5 and abs(difference.x) < 0.4:
			side = "down"			
		$AnimationPlayer.current_animation = "shoot_"+ side
		return
	$AnimationPlayer.current_animation = "run" if x_direction else "idle"

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


func _on_wall_check_area_body_entered(_body):
	x_direction *= -1
	
func check_cliff():
	if x_direction > 0 and not $FloorRays/Right.get_collider():
		x_direction = -1
	if x_direction < 0 and not $FloorRays/Left.get_collider():
		x_direction = 1

func trigger_attack():
	var dir = (player.position - position).normalized()
	shoot.emit(position + dir * 20, dir, Global.guns.AK)

func get_sprites():
	return [$Sprite2D]
