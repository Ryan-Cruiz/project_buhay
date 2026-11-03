extends Area2D
@export var scenePath = ""
var entered = false
@export var position_x = 0
@export var position_y = 0
@onready var spawn = $Spawn
func _ready() -> void:
	$Label.hide()
	$Spawn.position = Vector2(position_x,position_y)
	pass

func _enter_door():
	await get_tree().create_timer(0.5).timeout
	StageManager.go_to_level(scenePath)
	StageManager.isRunning = true
	print(Vector2(position_x,position_y))
	#var scene = folderPath + scenePath + ".tscn";
	#get_tree().change_scene_to_file(scene)
	
func _on_body_entered(body: CharacterBody2D) -> void:
		entered = true
		$Label.show()
	


func _on_body_exited(body: CharacterBody2D) -> void:
		entered = false;
		$Label.hide();

func _process(delta: float) -> void:
	if entered == true:
		if Input.is_action_just_pressed("interact"):
			_enter_door()
