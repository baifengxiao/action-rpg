extends CharacterBody2D

const ACCELERATION = 15 * 60
const MAX_SPEED = 100
const FRICTION = 10 * 60

var input_vector = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animationState =animation_tree.get("parameters/playback")

func _physics_process(delta: float) -> void:
	
	# 更新输入向量（仅当输入发生变化时才重新计算归一化）
	input_vector.x=Input.get_axis("ui_left", "ui_right")
	input_vector.y=Input.get_axis("ui_up", "ui_down")
	if input_vector.length() > 0.01: # 防止除以零
		input_vector = input_vector.normalized()
	
	#非零向量
	if input_vector != Vector2.ZERO:
		
		#if input_vector.x >0:
			#animation_player.play("RunRight")
		#else :
			#animation_player.play("RunLeft")
		animation_tree.set("parameters/Idle/blend_position",input_vector)
		animation_tree.set("parameters/Run/blend_position",input_vector)
		animationState.travel("Run")
		
		velocity = velocity.move_toward(input_vector * MAX_SPEED,ACCELERATION * delta - FRICTION * delta)
	else :
		animationState.travel("Idle")
		#animation_player.play("IdleRight")
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta)	#摩擦力
	
	move_and_slide()

