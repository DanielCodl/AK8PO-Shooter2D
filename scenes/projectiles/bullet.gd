extends Area2D

var direction: Vector2
var speed: int
var damage: int

func setup(pos, dir, type):
	position = pos
	direction = dir.normalized()
	if type in [Global.guns.AK, Global.guns.ROCKET]:
		$Sprite2D.texture = Global.gun_data[type]["texture"]
		speed = Global.gun_data[type]["speed"]
		damage = Global.gun_data[type]["damage"]


func _process(delta):
	position += direction * speed * delta
