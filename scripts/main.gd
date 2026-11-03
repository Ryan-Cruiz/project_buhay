extends Node2D

# Called when the node enters the scene tree for the first time.
var npc = preload("res://components/npc.tscn");
func _ready() -> void:
	#$Player.start()
	new_game()
	pass # Replace with function body.
func new_game():
	if StageManager.isRunning:
		var door = StageManager.globalScenePath
		print(door)
		var scene = get_node("Doors/"+door+"/Spawn")
		$Player.start(scene.global_position)
		print(scene.global_position)
	else:
		$Player.start($StartPosition.position)
	pass
pass


func _on_button_pressed() -> void:
	Config.save_game()
	print('wat')


func _on_button_2_pressed() -> void:
	Config.load_game()
