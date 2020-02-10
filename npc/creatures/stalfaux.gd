extends "res://engine/entity.gd"

const DAMAGE = 1

var moveTimerLength = 15
var moveTimer = 0

func ready():
	$anim.play("default")
	moveDir = dir.rand()
	
func _physics_process(delta):
	movementLoop()
	damageLoop()
	
	if moveTimer >0:
		moveTimer -= 1
	if moveTimer == 0 || is_on_wall():
			moveDir = dir.rand()
			moveTimer = moveTimerLength
			
