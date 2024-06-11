extends CharacterBody2D

const ENEMY_DEATH_EFFECT = preload("res://Effects/enemy_death_effect.tscn")

@export var ACCELERATION = 300
@export var MAX_SPEED = 10
@export var FRICTION = 100


enum{
	IDLE,
	WANDER,
	CHASE
}

#初始化击退向量
var knockback = Vector2.ZERO

var state = CHASE

@onready var playerDetectionZone = $PlayerDetectionZone

@onready var stats: Node2D = $Stats
@onready var sprite = $AnimatedSprite2D
@onready var hurtbox: Area2D = $Hurtbox
@onready var soft_collsion: Area2D = $softCollsion


func _physics_process(delta):
	
	##定义击退的速度向量
	##不能连写，连写没有保留前一帧的 velocity 减速状态，就会停不下来！！
	#knockback = knockback.move_toward(Vector2.ZERO,FRICTION * delta)
	#velocity = knockback
	##引入进了IDLE，不用这个了
	
	move_and_slide()
	
	#knockback=velocity
	
	match state:
		IDLE:
			# 蝙蝠的击退速度
			velocity=velocity.move_toward(Vector2.ZERO,FRICTION * delta)
			seek_player()
			
		WANDER:
			pass
			
		CHASE:
			
			
			var player = playerDetectionZone.player
			
			if player != null:
				
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED ,ACCELERATION * delta)
			else :
				#避免离开时追赶方向停不下来
				state = IDLE
	
			#调整追赶中的方向
			sprite.flip_h = velocity.x < 0
	if soft_collsion.is_colliding():
		velocity += soft_collsion.get_push_vector() * delta * 400
	move_and_slide()	
	#TODO，这里的逻辑有得研究，这里seek_player() 放在match语句前执行就好，IDLE和CHASE都需要状态转换，而且它CHASE的那个判断很迷，就是等于seekplayer
		
func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE	
		

func _on_hurtbox_area_entered(area):
	
	stats.health -= area.damage
	
	#if stats.health <= 0:
		#queue_free()
		
	#knockback_vector后面定义，测试用随便一个方向，比如右方向替换
	knockback = area.knockback_vector *120
	hurtbox.create_hit_effect()
	
#func _on_hurtbox_area_entered(area: Area2D) -> void:
	#queue_free()

func _on_stats_no_health() -> void:
	queue_free()
	var enemyDeathEffect = ENEMY_DEATH_EFFECT.instantiate()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	
