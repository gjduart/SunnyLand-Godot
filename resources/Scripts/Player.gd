extends KinematicBody2D



var gravity = 1000
var velocity = Vector2.ZERO
var move_speed = 200 
var jump_force = -350
var is_grounded 
onready var raycasts =$raycasts

func get_states():
	velocity.x = 0 
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var Jump = Input.is_action_pressed("jump")
	var down = Input.is_action_pressed("ui_down")
	

	
	if (right):
		velocity.x += move_speed
		$AnimatedSprite.play("Skip")
		$AnimatedSprite.flip_h = false
		
	if (left):
		velocity.x -= move_speed
		$AnimatedSprite.play("Skip")
		$AnimatedSprite.flip_h = true
	if (!left and !right and !Jump):
		$AnimatedSprite.play("Idle")
	if(down and (!left and !right and !Jump)):
		$AnimatedSprite.play("Duck")
		
func _physics_process(delta):
	velocity.y += gravity * delta
	get_states()
	velocity = move_and_slide(velocity, Vector2(0, -1))
	is_grounded = _check_is_ground()
func _input(event):
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y += jump_force
		$AnimatedSprite.play("jump")

func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			print("colidiu")
			return true
			
		return false
