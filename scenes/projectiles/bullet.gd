extends Area2D

var direction: Vector2
var speed: int
var damage: int
var explosive := false
signal detonate(pos: Vector2)

func setup(pos, dir, type):
	position = pos
	direction = dir.normalized()
	if type in [Global.guns.AK, Global.guns.ROCKET]:
		$Sprite2D.texture = Global.gun_data[type]["texture"]
		speed = Global.gun_data[type]["speed"]
		damage = Global.gun_data[type]["damage"]
		explosive = type == Global.guns.ROCKET
	else:
		$CollisionShape2D.disabled =  true
		$Sprite2D.hide()
		$PointLight2D.hide()

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	detonate.emit(position)
	if "hit" in body:
		body.hit(damage, body.get_sprites())
	queue_free()


func _on_kill_timer_timeout():
	queue_free()
