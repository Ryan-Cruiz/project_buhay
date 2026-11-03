extends HSlider

@export var audio_bus_name: String
var audio_id
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_id = AudioServer.get_bus_index(audio_bus_name)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_music_control_value_changed(value: float) -> void:
	
	pass # Replace with function body.


func _on_music_control_changed() -> void:
	pass # Replace with function body.


func _on_changed() -> void:
	pass # Replace with function body.

func _on_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_id,db)
	pass # Replace with function body.
