extends Entity

var active := false
var speed := Global.enemy_parameters["drone"]["speed"]
@onready var player = get_tree().get_first_node_in_group("Player")
signal detonate(pos: Vector2)

func _ready():
	health = Global.enemy_parameters["drone"]["health"]

func _process(_delta):
	if active:
		var direction = (player.position - position).normalized()
		velocity = direction * speed
		move_and_slide()

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


func _on_player_detection_area_body_entered(_body):
	active = true


func _on_collision_detection_area_body_entered(body):
	if body != self:
		detonate.emit(global_position)
		queue_free()
		
func get_sprites():
	return [$AnimatedSprite2D]
