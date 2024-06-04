extends CharacterBody2D

const ACCELERATION = 15 * 60
const MAX_SPEED = 100
const FRICTION = 10 * 60

enum {
	MOVE,
	ATTACK
}

var state = MOVE
var input_vector = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animationState =animation_tree.get("parameters/playback")
@onready var sword_hitbox: Area2D = $HitboxPivot/SwordHitbox

func _ready() -> void:
	animation_tree.active=true

func _physics_process(delta: float) -> void:
	
	match state:
		MOVE:
			move_state(delta)
		
		ATTACK:
			attack_state(delta)
		
func move_state(delta):
	# 更新输入向量（仅当输入发生变化时才重新计算归一化）
	input_vector.x=Input.get_axis("ui_left", "ui_right")
	input_vector.y=Input.get_axis("ui_up", "ui_down")
	if input_vector.length() > 0.01: # 防止除以零
		input_vector = input_vector.normalized()
	
	#非零向量
	if input_vector != Vector2.ZERO:
		
		#击退方向同步移动方向
		sword_hitbox.knockback_vector=input_vector
		animation_tree.set("parameters/Idle/blend_position",input_vector)
		animation_tree.set("parameters/Run/blend_position",input_vector)
		animation_tree.set("parameters/Attack/blend_position",input_vector)
		animationState.travel("Run")
		
		velocity = velocity.move_toward(input_vector * MAX_SPEED,ACCELERATION * delta - FRICTION * delta)
	else :
		animationState.travel("Idle")
		#animation_player.play("IdleRight")
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION * delta)	#摩擦力
	
	move_and_slide()
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state(delta):
	# 清除记忆的速度
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func attack_animation_finished():
	state = MOVE
