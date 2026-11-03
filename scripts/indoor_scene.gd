extends Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$Player.start(StageManager.go_to_level("indoor",455,230))
	$Player.start($door/Spawn.position)
	pass # Replace with function body.
