extends KinematicBody2D

export(String, "NULL", "PLAYER", "ENEMY") var TYPE

export (float) var SPEED = 0
	
var moveDir = Vector2(0,0)
var knockDir = Vector2(0,0)
var spriteDir = "down"

var hitstun = 0
var health = 1

func movementLoop():
	var motion 
	if hitstun == 0:
		motion = moveDir.normalized() * SPEED
	else:
		motion = knockDir.normalized * SPEED * 125
	move_and_slide(motion, Vector2(0,0))

func spriteDirLoop():
	match moveDir:
		Vector2(-1,0):
			spriteDir = "left"
		Vector2(1,0):
			spriteDir = "right"
		Vector2(0,-1):
			spriteDir = "up"
		Vector2(0,1):
			spriteDir = "down"
			
			
func animSwitch(animation):
	var newAnim = str(animation, spriteDir)
	if $anim.play() != newAnim:
		$anim.play(newAnim)
		
func damageLoop():
	if hitstun > 0:
		hitstun -= 1
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		if hitstun ==0 and body.get("DAMAGE") != null && body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockDir = global_transform.origin - body.global_transform.origin
			
func useItem(item):
	var newItem = item.instance()
	newItem.add_to_group(str(newItem.get_name(), self))
	add_child(newItem)
	if get_tree().get_nodes_group(str(newItem.get_name(), self)).size() > newItem.maxamount:
		newItem.queue_free()

