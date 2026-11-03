extends CharacterBody2D

const speed : int = 50
var curr_state: int = IDLE

var dir = Vector2.UP
var start_pos: Vector2

var isRoaming: bool = true
var isChatting: bool = false

var player: Node2D
var player_in_chat_zone : bool = false
enum {
	IDLE,
	NEW_DIR,
	MOVE
}
@export var npc_name: String
@onready var dialogueRect := $Dialogue/NinePatchRect;
@onready var dialogue := $Dialogue;
@onready var timer: Timer = $Timer
@onready var sprite := $AnimatedSprite2D
var screen_size: Vector2

func _enter_tree() -> void:
	var entry = PersistentData.get_data_value(get_path(),"position")
	if entry == null:
		return
	global_position = entry
func _exit_tree() -> void:
	PersistentData.store_data_value(get_path(),"position",global_position)
	pass
func _ready() -> void:
	screen_size = get_viewport_rect().size;
	randomize()
	#start_pos = position
	
func _process(delta: float) -> void:
	if curr_state == 0 or curr_state == 1:
		sprite.play("idle")
	elif curr_state == 2 and !isChatting:
		if dir.x == -1:
			sprite.play("side")
			sprite.flip_h = true
		if dir.x == 1:
			sprite.flip_h = false
			sprite.play("side")
		if dir.y == -1:
			sprite.play("up")
		if dir.y == 1:
			sprite.play("down")
			
	if Input.is_action_just_pressed("interact") and player_in_chat_zone:
		print("chatting with npc")
		$Dialogue.start()
		isRoaming = false
		isChatting = true
		sprite.play("idle")
	if isRoaming:
		match curr_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.UP,Vector2.LEFT,Vector2.DOWN,Vector2.RIGHT])
			MOVE:
				move(delta)
	#print(player_in_chat_zone)
func choose(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	if !isChatting:
		position += dir * speed * delta
		move_and_slide()
		position = position.clamp(Vector2.ZERO,screen_size);	
				
	


func _on_chat_area_detection_body_entered(body: CharacterBody2D) -> void:
	if body.name == "Player":
		print(player_in_chat_zone,body.name)
		player = body
		player_in_chat_zone = true


func _on_chat_area_detection_body_exited(body: CharacterBody2D) -> void:
	if body.name == "Player":
		print(player_in_chat_zone,body.name)
		dialogueRect.hide()
		_on_dialogue_dialogue_finished()
		player_in_chat_zone = false


func _on_timer_timeout() -> void:
	timer.wait_time = choose([1,1.5,2])
	curr_state = choose([IDLE,NEW_DIR,MOVE])


func _on_dialogue_dialogue_finished() -> void:
	dialogueRect.hide()
	dialogue.curr_dialogue_id = -1
	isChatting = false
	isRoaming = true
	pass # Replace with function body.

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
	}
	return save_dict
