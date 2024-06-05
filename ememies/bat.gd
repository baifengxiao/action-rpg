extends CharacterBody2D

#初始化击退向量
var knockback = Vector2.ZERO

@onready var stats: Node2D = $Stats

func _physics_process(delta):
	
	#定义击退的速度向量
	#不能连写，连写没有保留前一帧的 velocity 减速状态，就会停不下来！！
	knockback = knockback.move_toward(Vector2.ZERO,200 * delta)
	velocity = knockback
	move_and_slide()
	
	#knockback=velocity
	
func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	#if stats.health <= 0:
		#queue_free()
		
	#knockback_vector后面定义，测试用随便一个方向，比如右方向替换
	knockback = area.knockback_vector *120

#func _on_hurtbox_area_entered(area: Area2D) -> void:
	#queue_free()

func _on_stats_no_health() -> void:
	queue_free()
