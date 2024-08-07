extends Node

enum guns {AK, SHOTGUN, ROCKET}
const enemy_parameters = {
	"drone": {"speed": 110, "health": 20, "damage": 15},
	"soldier": {"speed": 50, "health": 60},
	"monster": {"health": 200}
}

# Global
const gun_data = {
	guns.AK: {'damage': 20, 'speed': 200, 'texture': preload("res://graphics/guns/projectiles/default.png")},
	guns.ROCKET: {'damage': 60, 'speed': 120, 'texture': preload("res://graphics/guns/projectiles/large.png")},
	guns.SHOTGUN: {'damage': 30, 'range': 100},
}
