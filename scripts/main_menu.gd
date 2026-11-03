extends CanvasLayer

@onready var main_buttons: VBoxContainer = $main_buttons
@onready var options: Panel = $options
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	options.hide();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/main.tscn")
	pass # Replace with function body.


func _on_option_pressed() -> void:
	main_buttons.hide()
	options.show()
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_back_pressed() -> void:
	main_buttons.show()
	options.hide()
	pass # Replace with function body.
