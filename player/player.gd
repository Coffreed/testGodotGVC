extends "res://engine/entity.gd"

var state = "default"

func _physics_process(delta):
	match state:
		"default":
			stateDefault()

func stateDefault():
	controlsLoop()
	movementLoop()
	spriteDirLoop()
	
	if is_on_wall():
		if spriteDir == "left" and test_move(transform, Vector2(-1,0)):
			animSwitch("push")
		if spriteDir == "right" and test_move(transform, Vector2(1,0)):
			animSwitch("push")
		if spriteDir == "up" and test_move(transform, Vector2(0,-1)):
			animSwitch("push")
		if spriteDir == "down" and test_move(transform, Vector2(0,1)):
			animSwitch("push")
	elif moveDir != Vector2(0,0):
		animSwitch("walk")
	else:
		animSwitch("idle")

	
func controlsLoop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	moveDir.x = -int(LEFT) + int(RIGHT)
	moveDir.y = -int(UP) + int(DOWN)

func movementLoop():
	var motion = moveDir.normalized() * SPEED
	move_and_slide(motion, Vector2(0,0))
	
	
