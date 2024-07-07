@tool
extends Node2D

@export_enum("0", "1", "2", "3", "4", "5") var type = "0":
	set(value):
		if get_child_count() > 0 and value != null:
			type = value
			for child in $Options.get_children():
				child.hide()
			$Options.get_child(int(type)).show()

func _process(delta):
	pass
