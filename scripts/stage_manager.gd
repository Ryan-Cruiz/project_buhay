extends Node2D

const main = preload("res://levels/main.tscn")
const indoor = preload("res://levels/indoor_scene.tscn")
const indoor2 = preload("res://levels/indoor_2.tscn")

var isRunning: bool = false
var globalScenePath: String
func go_to_level(scene_path):
	var scene_to_load: PackedScene
	match scene_path:
		"world":
			scene_to_load = main
		"indoor":
			globalScenePath = scene_path
			scene_to_load = indoor
			
		"indoor2":
			globalScenePath = scene_path
			scene_to_load = indoor2
			
	if scene_to_load != null: 
		get_tree().change_scene_to_packed(scene_to_load)
	
