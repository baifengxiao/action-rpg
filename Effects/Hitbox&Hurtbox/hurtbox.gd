extends Area2D

#@export var show_hit:bool = true

const HIT_EFFECT = preload("res://Effects/hit_effect.tscn")
var invincible  = false:set = set_invincible
@onready var timer = $Timer

signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else :
		emit_signal("invincibility_ended")


#用这个函数开始无敌
func start_invincibility(duration):
	#开始无敌就把无敌状态置为true
	self.invincible = true
	#无敌开始就开启计时器，duration就是计时器的时间
	
	timer.start(duration)

func create_hit_effect():
	

	var effect = HIT_EFFECT.instantiate()
	
	#不使用get_parent().add_child()实例化，因为parent会被free（）
	var main = get_tree().current_scene
	
	main.add_child(effect)
	effect.global_position = global_position


func _on_timer_timeout() -> void:
	#必须加self，因为上面有invincible
	self.invincible = false

#开始的时候，禁用mask检测，之后再开启
func _on_invincibility_started() -> void:
	set_deferred("monitoring",false)
	#monitoring = false
func _on_invincibility_ended() -> void:
	monitoring = true


#func _on_area_entered(area: Area2D) -> void:
	#print("555")
	#pass # Replace with function body.
