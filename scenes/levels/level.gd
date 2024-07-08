extends Node2D

const explosion_scene := preload("res://scenes/projectiles/explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for entity in $Main/Entities.get_children():
		if entity.has_signal("detonate"):
			entity.connect("detonate", create_explosion)

func create_explosion(pos):
	var explosion = explosion_scene.instantiate()
	$Main/Projectiles.add_child(explosion)
	explosion.position = pos
