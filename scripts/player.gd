extends CharacterBody2D

class_name Player
@export var speed = 240;
var screen_size;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size;
	#Config.load_game()
	pass # Replace with function body.
func start(pos):
	position = pos;
	show();
	$CollisionShape2D.disabled = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2.ZERO;
	if Input.is_action_pressed("move_up"):
		$AnimatedSprite2D.animation = "up";
		velocity.y -= 1;
	if Input.is_action_pressed("move_down"):
		$AnimatedSprite2D.animation = "down";
		velocity.y += 1;
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.animation = "side";
		velocity.x -= 1;
	if Input.is_action_pressed("move_right"):
		$AnimatedSprite2D.animation = "side";
		velocity.x += 1;
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed;
		$AnimatedSprite2D.play();
	else:
		$AnimatedSprite2D.animation = "idle";	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true;
	else:
		$AnimatedSprite2D.flip_h = false;
	position += velocity * delta;
	move_and_slide()
	position = position.clamp(Vector2.ZERO,screen_size);
	pass
