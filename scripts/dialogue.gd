extends Control

@export_file("*.json") var d_file
signal dialogue_finished
var dialogue: Array = []
var curr_dialogue_id: int = 0  
var d_active: bool = false
# Called when the node enters the scene tree for the first time.
@onready var dialogueRect := $NinePatchRect
func _ready() -> void:
	dialogueRect.hide()
	
func start():
	dialogueRect.show()
	dialogue = load_dialogue()
	if d_active:
		return
	d_active = true
	curr_dialogue_id = -1
	next_script()

func load_dialogue() -> Array:
	var file = FileAccess.open(d_file,FileAccess.READ)
	var dialogue = JSON.parse_string(file.get_as_text())
	return dialogue
func _input(event: InputEvent) -> void:
	if !d_active:
		return
	if event.is_action_pressed("ui_accept"):
		next_script()

func next_script():
	curr_dialogue_id += 1
	if curr_dialogue_id >= len(dialogue):
		d_active = false
		dialogueRect.hide()
		emit_signal("dialogue_finished")
		return 
	$NinePatchRect/Name.text = dialogue[curr_dialogue_id]['name']
	$NinePatchRect/Text.text = dialogue[curr_dialogue_id]['text']
