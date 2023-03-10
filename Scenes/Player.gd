extends KinematicBody2D

export(int) var SPEED = 100

onready var sprite = $Sprite
onready var animationTree = $AnimationTree
onready var stateMachine = animationTree.get("parameters/playback")

func _physics_process(delta):
	var input_xy = getPlayerInput()
	
	var velocity = move_and_slide(input_xy * SPEED)
	
	if (velocity == Vector2.ZERO):
		stateMachine.call_deferred("idle")
	else:
		stateMachine.call_deferred("run")
	
	setFlipDirection(velocity)
	
	
func getPlayerInput():
	var input_vector = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	return input_vector

func setFlipDirection(velocity : Vector2):
	if (velocity.x > 0):
		sprite.flip_h = false
	elif (velocity.x < 0):
		sprite.flip_h = true
