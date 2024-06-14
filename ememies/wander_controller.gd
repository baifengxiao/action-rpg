extends Node2D

@export var wander_range:int = 32

#小怪开始游离位置
@onready var start_position = global_position
#游离目标位置
@onready var target_position = global_position

@onready var timer: Timer = $Timer

#不加开始时不会移动，因为@onready var target_position = global_position
func _ready() -> void:
	update_target_position()

func update_target_position():
	
	#随机游荡位置
	var target_vector = Vector2(randi_range(-wander_range,wander_range),randi_range(-wander_range,wander_range))
	target_position = start_position + target_vector

#剩余时间
func get_time_left():
	
	
	return timer.time_left

func start_wander_timer(duration):
	timer.start(duration)

func _on_timer_timeout() -> void:
	#更新目标位置
	update_target_position()
