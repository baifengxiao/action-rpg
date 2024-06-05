extends Node2D

@export var max_health:int = 1
@onready var health  = max_health:set=set_health

signal no_health

#health被设置时，set函数会被自动调用
func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")
