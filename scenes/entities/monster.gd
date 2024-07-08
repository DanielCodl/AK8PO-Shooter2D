extends Entity

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var player_cam = player.get_cam()
@onready var cam_size = player_cam.get_viewport_rect().size.x / player_cam.zoom.x
@export var limits: Vector2i

var y_range := Vector2(-50,50)
var y_offset: float

var rng = RandomNumberGenerator.new()

func _process(delta):
	var x = player.position.x + cam_size / 2 - 10
	x = max(limits.x, min(limits.y, x))
	var y = player.position.y + y_offset
	position = Vector2(x,y)

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


func _on_attack_timer_timeout():
	$AnimationPlayer.current_animation = "attack"
	$Timers/AttackTimer.wait_time = rng.randf_range(0.5,2.0)
	$Timers/AttackTimer.start()

func _on_move_timer_timeout():
	var tween = create_tween()
	tween.tween_property(self, "y_offset", rng.randf_range(y_range.x,y_range.y), 0.6)
	tween.tween_callback($Timers/MoveTimer.start)

func return_to_idle():
	$AnimationPlayer.current_animation = "idle"
