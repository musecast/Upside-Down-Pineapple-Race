extends CharacterBody2D
signal spike_collision


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	#connect("body_entered", self, "_on_body_entered")
	pass

func _physics_process(delta):
			
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		#velocity.y = move_toward(velocity.x, 0, SPEED)
		gravity = -gravity
		if $AnimatedSprite2D.flip_v == false:
			$AnimatedSprite2D.flip_v = true
		else:
			$AnimatedSprite2D.flip_v = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = false
		
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")
		if Input.is_action_pressed("ui_down"):
			$AnimatedSprite2D.play("crouch")
		

	move_and_slide()

	
func body_entered(body):
	if body.is_in_group("spikes"): 
		var audio = get_node("/root/Node2D/AudioStreamPlayer")
		#Music.musicProgress = get_tree().get_playback_position(AudioStreamPlayer)
		Music.musicProgress = audio.get_playback_position() 
		get_tree().reload_current_scene()



func _on_spike_detection_body_shape_entered(body):
	if body.is_in_group("spikes"):
		var audio = get_node("/root/Node2D/AudioStreamPlayer")
		Music.musicProgress = audio.get_playback_position() 
		get_tree().reload_current_scene()
		
